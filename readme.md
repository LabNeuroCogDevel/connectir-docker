[`connectir`](https://github.com/czarrar/connectir) requires niftir, niftir requires older gcc and older Rcpp.
Use docker to get GCC from Debian oldstable (jessie). 
 - `install_r.bash` installs R and dev dependencies
 - `install.R` install connectir and dependencies
 - `Dockerfile` puts it all in a container

Build:

```
docker build -t connectir .
```
