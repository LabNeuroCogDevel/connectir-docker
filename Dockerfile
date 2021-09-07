FROM debian:jessie
# system depends
COPY 00_install_system_depends.bash 02_cleanup.bash /usr/local/bin/
RUN /usr/local/bin/00_install_system_depends.bash

# R depends
COPY 01_connectir.R  /usr/local/bin
RUN bash -c "R CMD BATCH /usr/local/bin/01_connectir.R  >(cat)"

# cleanup
RUN /usr/local/bin/02_cleanup.bash

# set to R for interactive
ENTRYPOINT ["/usr/bin/R"]
