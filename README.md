# Docker Master

Run a single vagrant machine as docker host to similar projects. Aims to run a single vagrant host for ruby, php, node, python etc web projects.

## Aim
- use a single large CPU/memory VM rather then multiple smaller VMs
- better disk space efficieiencey
- faster rebuild of projects as the vagrant client / docker host doesnt get rebuilt

Tools
- Ubuntu Trusty 14.04 LTS
- switch to ansible

TODO
- docker master should always be vanilla
- dockerfiles per project specifiy the difference
- separate DB server, or docker-master runs as DB
- GuestAdditions versions on your host (5.0.10) and guest (4.3.34) do not match.
- colour the prompt so you know you are on docker master
- docker-master.dev: stdin: is not a tty