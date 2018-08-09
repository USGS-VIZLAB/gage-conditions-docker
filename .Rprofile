# we should only copy packages if we're opening the project from the rocker
# image. not sure how reliable the grepl below is across systems
is_rocker_image <- grepl('docker', Sys.info()[['release']])
if(is_rocker_image) {
  #### -- Docker adjustments for packrat -- ####
  rocker_lib <- 'packrat/lib-rocker'
  system_libs <- packrat:::getDefaultLibPaths()
  system_pkgs <- rownames(utils::installed.packages(lib.loc=system_libs))
  if(!dir.exists(rocker_lib)) dir.create(rocker_lib)
  rocker_pkgs <- dir(rocker_lib)
  need_pkgs <- setdiff(system_pkgs, rocker_pkgs)
  message(sprintf("Copying %s packages from default lib paths (%s) to %s", length(need_pkgs), paste(system_libs, collapse=', '), rocker_lib))
  for(pkg in need_pkgs) {
    sys_path <- find.package(pkg, system_libs)
    rocker_path <- file.path(rocker_lib, pkg)
    unlink(rocker_path)
    file.copy(from=sys_path, to=rocker_lib, recursive=TRUE, overwrite=TRUE)
  }
  
  Sys.setenv(R_LIBS=rocker_lib)
  .Library.site=rocker_lib
  Sys.setenv(R_LIBS_USER=rocker_lib)
  .Library=rocker_lib
  Sys.setenv(R_PACKRAT_DEFAULT_LIBPATHS=rocker_lib)
  Sys.setenv(R_PACKRAT_SITE_LIBRARY=rocker_lib)
  Sys.setenv(R_PACKRAT_SYSTEM_LIBRARY=rocker_lib)
  #.libPaths(rocker_lib)
  message(sprintf("%s packages installed", nrow(utils::installed.packages(.libPaths()[1]))))
  
  #### -- Packrat Autoloader (version 0.4.9-3) -- ####
  source("packrat/init.R")
  #### -- End Packrat Autoloader -- ####
  
  .libPaths(c(.libPaths()[1:2], rocker_lib))
  message(sprintf('.libPaths():\n%s', paste0('  ', .libPaths(), collapse='\n')))
  message(sprintf("%s packages available to packrat", nrow(utils::installed.packages())))
  message(sprintf("In %s: %s", as.character(warnings()[[1]][1]), names(warnings()[1])))
  #library(abind)
}
