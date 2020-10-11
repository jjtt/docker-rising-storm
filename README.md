= Rising Storm 2 - Vietnam dedicated server in a container on linux =

1. Read the documentation: https://wiki.rs2vietnam.com/index.php?title=DedicatedServer
1. clone this repo
1. `docker build -t risingstorm .`
1. `cd /somewhere/with/22+/gigs/free`
1. `mkdir gamedir`
1. add liberal r/w at least for uid=1000, gid=1000 (user "user" inside container)
1. install/update game `docker run --rm -ti -v $PWD/gamedir:/home/user/Steam risingstorm update`
1. Customise configuration in `gamedir/steamapps/common/Rising Storm 2 - Dedicated Server/ROGame/Config`
  * web admin ListenPort is configured in ROWeb.ini
1. `docker run --rm -ti --net=host -v $PWD/gamedir:/home/user/Steam risingstorm run`

# Known issues

1. Without `--net=host` the server publishes an ip of `0.0.0.0` and connecting to it does not work


# Thanks

* https://github.com/BitR/empyrion-docker
