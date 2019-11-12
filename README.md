# Boot to Qt Docker image

## How to build b2qt image
### Using Docker from CLI
```bash
cd path/to/context/ # it must contain:
                    # b2qt toolchain package (b2qt.tz.bz2) 
                    # Dockerfile
                    # compile.sh 
                    # b2qtgo.sh
docker build -t itdelsat/b2qt:<tag-name> . # <tag-name> is optional
```
### Using GitHub and DockerHub
This GitHub's repository is connected with a DockerHub one, so when one publish 
changes to the remote repository, DockerHub will build the image according to 
the Dockerfile.
```bash
git clone https://github.com/itdelsat/b2qt.git
cd b2qt/ # it is the context
edit Dockerfile or add some files to the context...
git add ...
git commit -m "..."
git push
```
## Run b2qt image
- First of all, you should create a directory <local> which 
  must contain the CIM-GUI repository that you want to build and 
  another one <building>, which will have the Minibank 
  building's output.
- When you execute the command line shown below, <building> 
  directory should contain a file called Minibank (binary for 
  ARM platform).
- You must name the container's mount directory <output>
- Usage:
```bash
      cd ~
      mkdir minibank
      mkdir minibank/build
      cd minibank
      git clone https://https://github.com/itdelsat/CIM-GUI.git
      docker run --rm -v ~/minibank:/output --name b2qt-builder b2qt
```
```bash
docker run --rm -v path/to/<local>:/<output> b2qt
```
## Run b2qt image executing Bash shell (overriding its entrypoint)
```bash
docker run --rm -v ~/minibank:/output -it --entrypoint=/bin/bash b2qt
docker run --rm -v path/to/<local>:/<output> -it --entrypoint=/bin/bash b2qt
```
## Publish b2qt image
```bash
docker login
docker push itdelsat/b2qt:latest
```
## Pull b2qt image
Docker Hub is the place where open Docker images are stored. When you ran 
b2qt first image by typing:
```bash
docker run --rm -v path/to/<local>:/<output> itdelsat/b2qt:latest
```
The software first checked if this image is available on your computer and 
since it wasn’t it downloaded the image from Docker Hub. So getting an image 
from Docker Hub works sort of automatically. If you just want to pull the 
image but not run it, you can also do:
```bash
sudo docker login
docker pull itdelsat/b2qt:latest
```
