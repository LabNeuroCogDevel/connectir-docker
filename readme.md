# Docker container for connectir

[`connectir`](http://czarrar.github.io/connectir/) requires niftir, niftir requires older gcc and older Rcpp.

We can use docker to get GCC from Debian oldstable (jessie), compile dependencies, and provide access to `connectir`
 - `00_install_system_depends.bash` installs R and dev dependencies
 - `01_connectir.R` install connectir and dependencies (called within `00_install_system_depends.bash`)
 - `Dockerfile` puts it all in a container

## Build

```bash
docker build -t connectir .
```

## Usage

### Simplified Usage

```bash
source connectir.src.bash # only need once per bash session
# added aliases to match tutorial 
connectir_subdist.R  -i ...
connectir_mdmr.R  -i ...
# OR, use provided function to wrap docker
connectir subdist -i ...
connectir mdmr -i ...
```

### Docker setup/info

```bash
# R console (connectir and depends installed)
docker run -it connectir  

# run connectir_mdmr (shows help)
docker run --entrypoint connectir_mdmr.R  connectir

# export current working directory to docker container
docker run -v "$(pwd):$(pwd)" -w "$(pwd)" --entrypoint connectir_subdist.R connectir
```

### Example useage from docker
```bash
# 0. export current location and start contianer there
#   - cannot use dirs up the tree, e.g no ../
# 1. run example like http://czarrar.github.io/connectir/
docker run -v "$(pwd):$(pwd)" -w "$(pwd)" --entrypoint connectir_subdist.R connectir \
    -i functional_path_list.txt \ 
    --automask1 \
     --brainmask1 standard_grey_matter.nii.gz \ 
    --bg standard_brain_4mm.nii.gz \ 
    --memlimit 20 -c 3 -t 4 \
     subject_distances_outdi
docker run -v "$(pwd):$(pwd)" -w "$(pwd)" --entrypoint connectir_mdmr.R  connectir \
    -i subject_distances_outdir \
     --formula FSIQ + Age + Sex + meanFD \
     --model model_evs.csv \ 
    --factors2perm FSIQ \ 
    --memlimit 8 -c 3 -t 4 \
    --save-perms --ignoreprocerror \
     iq_outdir.mdmr
```

