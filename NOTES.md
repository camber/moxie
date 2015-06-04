App
  -id
  -name
  -repo

Environment
  -id
  -app
  -name
  -config

Build
  -id
  -app
  -branch
  -version
  -status

Image
  -app
  -build
  -env
  -version

Instance
  -app
  -image
  -cluster

Cluster
  -name
  -app
  -image
  -instances
  -size

mox app
mox app prx

mox create --name=prx --repo=git@github.com/PrintReleaf/prx.git

mox builds
mox builds --app=prx
mox build prx
mox build prx --branch=master

mox releases
mox releases --app=prx
mox release prx
mox release prx --env=production
mox release prx --env=production --build=latest
mox release prx --env=production --build=master
mox release prx --env=production --build=master.20150601T234347

mox clusters
mox cluster create --name=prx-production --app=prx --image=latest
mox cluster update prx.production --image=latest --size=3
mox cluster delete prx.production
mox cluster restart


mox app list
mox app info
mox app create
mox app delete

mox env --app prx
mox env <id>

mox builds
mox builds --app=prx
mox build prx

mox apps
mox app

SET [id]  moxie:applications
STR json  moxie:application:123
SET [id]  moxie:application:123:environments
STR json  moxie:environment:456

Application.all()
Application.find(1)
Application.find([1,2,3])













git clone
  cd
  rm .git
  deploy/build
    bundle install
    bundle package
    precompile assets
  cd ..
  zip app dir
  upload zip to s3
  set build url
  set build status


