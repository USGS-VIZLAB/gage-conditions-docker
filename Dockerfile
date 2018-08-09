FROM rocker/geospatial:latest

# install node and npm (see https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
RUN sudo apt-get install -y curl &&\
  sudo apt-get install -y gnupg &&\
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - &&\
  sudo apt-get update &&\
  sudo apt-get install -y nodejs &&\
  sudo apt-get install -y build-essential

# install
RUN sudo npm install -g\
  webpack\
  webpack-cli\
  d3-geo-projection

# for use when building the docker image:
# use packrat and file.copy to add packages to the image
RUN mkdir /home/rstudio/gage-conditions-docker
VOLUME /home/rstudio/gage-conditions-docker
RUN R --args --bootstrap-packrat -e\
  "setwd('/home/rstudio/gage-conditions-docker');\
  packrat::packrat_mode(on=TRUE);\
  usrlib <- tail(.libPaths(), 1);\
  packrat::restore(overwrite.dirty=TRUE, prompt=FALSE);\
  srclib <- packrat::lib_dir();\
  pkgs <- dir(srclib, full.names=TRUE);\
  lapply(pkgs, function(pkg) {\
    file.copy(pkg, usrlib, recursive=TRUE, overwrite=TRUE);\
  });\
  setwd('..');"

# for use when developing the vizzy project: volume mapping
# allows you to directly edit the project files on your computer
RUN mkdir /home/rstudio/gage-conditions
VOLUME /home/rstudio/gage-conditions
