FROM debian:jessie
COPY 00_install_system_depends.bash 01_connectir.R /usr/local/bin/
RUN /usr/local/bin/00_install_system_depends.bash
ENTRYPOINT ["/usr/bin/R"]
