#!/usr/bin/env Rscript

## need niftir to compile
## last niftir source update was Jul 27 2016.
## successful setup:
##   debian:jessie w. newest R
##    o gcc  4.9.2  (old)
##    o Rcpp 0.12.5 (old)
##    o R    3.4.4  (new)
## failing setups:
##   old gcc (4.9.2 deb:jessie), new Rcpp (0.12.16)
##   new gcc (7.3.0 deb:stable), old Rcpp (0.12.5)

#options(repos="http://cran.us.r-project.org")
options(repos="http://cran.mirrors.hoobly.com")

# --- 0. system and build depends
# also see
# https://github.com/czarrar/Rinstall/blob/master/connectir_install.R

# for docker:r-base, would need to downgrade gcc
# system("apt-get update &&  apt-get install -y libssl-dev libcurl4-openssl-dev libssh2-1-dev")

# NB. installs newest version of Rcpp as depend, we will downgrade to compile niftir

# use devtools to install old Rcpp

# install other depencies
install.packages(c( "codetools", "testthat",
                   "optparse", "getopt",
                   "foreach", "doMC",
                   "RcppArmadillo", "bigmemory", "biganalytics",
                   "devtools",
                   "rlang", "purrr",
                   # these are not required, but might be nice
                   "tidyverse", "ggplot2"
                   ))

library(devtools)
install_github("cran/Rcpp", ref="b5bec57") # 0.12.5 (May 14 2016)
# redo with this Rcpp
install.packages(dependencies=F, c("bigmemory", "biganalytics"))
install_github("czarrar/bigalgebra")
install_github("czarrar/bigextensions")
install_github("czarrar/niftir")

# finally do the main thing
install_github("czarrar/connectir")

i <- installed.packages()
i[grep("Rcpp|big|niftir", i[, "Package"]), "Version"]
#        Rcpp bigextensions     bigmemory bigmemory.sri        niftir 
#    "0.12.5"         "0.1"      "4.5.33"       "0.1.3"         "0.2"
# all newest, save Rcpp (May 14 2016)
