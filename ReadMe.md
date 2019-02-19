## Dockerize shiny application (easily)

### ShinyDockerBase

ShinyDockerBase create a docker image to run shiny application.

Go to folder `dockershiny` (`cd dockershiny`).

Then, make sure to run ```docker build -t dockershiny .```  into this directory to get this image in local before create any application.

You can check that the image is created with ```docker images```. You should see a line with:
```text
REPOSITORY          TAG                 IMAGE ID            CREATED                  SIZE
dockershiny         latest              d88d828ede04        Less than a second ago   1.34GB
```

### Dockerize a Shiny App

#### Structure folder

You have to follow this directory structure in order to dockerize your shiny application:
```text
example
├── app
│   ├── Dockerfile # created when you run build_app.sh
│   ├── packages.json # created when you run packages_config.sh
│   ├── packages.R # optional : centralized packages call
│   ├── server.R # app itself (works with one app.R file)
│   └── ui.R # app itself
└── dockerize
    ├── build_app.sh
    ├── launch_app.sh
    ├── packages_config.R # R script to auto create packages.json (packages and version)
    ├── packages_config.sh
    └── stop_app.sh # stop docker image
```

#### Process

1) Copy folder ```dockerize``` into your app (please follow same directory structure) and go into this folder (`cd dockerize`):
```text
example
├── app
│   ├── server.R # app itself (works with one app.R file)
│   └── ui.R # app itself
└── dockerize
```

2) ```./packages_config.sh``` generate packages.json (packages used with the version installed) to install same environment in docker image,

3) ```./build_app.sh``` to build docker image,

4) ```./launch_app.sh``` to launch docker image (go to [http://localhost](http://localhost) to see your app running,

5) When you're done : ```stop_app.sh```.

*Note : you can simplify step 2, 3, 4 by launching ```./dockerize.sh```.*

### To Do

- clean ```stop_app.sh``` (now kill all docker images...)
- base image based on Alpine
- better handling of parameters in bash script
- handle failure in docker creation
