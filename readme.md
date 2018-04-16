[`connectir`](http://czarrar.github.io/connectir/) requires niftir, niftir requires older gcc and older Rcpp.
Use docker to get GCC from Debian oldstable (jessie). 
 - `00_install_system_depends.bash` installs R and dev dependencies
 - `01_connectir.R` install connectir and dependencies (called within `00_install_system_depends.bash`)
 - `Dockerfile` puts it all in a container

Build:

```bash
docker build -t connectir .
```

Run: 
```bash
docker run connectir 
docker run --entrypoint connectir_subdist.R connectir
docker run connectir -it connectir_subdist.R 
```
