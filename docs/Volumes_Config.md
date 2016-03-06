# Volumes Config - Demo Env


### CoreOS:

#### Nginx:

* Generated Config files: `/tmp/nginx/` (Mounted on nginx and dockgen container)
    - Nginx container dest: `/etc/nginx/conf.d/`
    - Dockgen container dest: `/etc/nginx/conf.d/`
* Main config file: `/home/core/config/nginx/nginx.conf` (Mounted on nginx container)
    - Nginx container dest: `/etc/nginx/nginx.conf`

#### Dock-gen nginx:

* Main config file: `/home/core/config/dockgen/nginx/docker-gen.cfg`
    - Dock-gen nginx dest: `/etc/docker-gen/docker-gen.cfg`
* Templates: `/home/core/templates/nginx/` 
    - Dock-gen nginx dest: `/etc/docker-gen/templates/`

#### Apache:

* Main config file: `/home/core/config/apache/httpd.conf` (Mounted on apache container)
    - Apache container dest: `/usr/local/apache2/conf/httpd.conf`

#### Datadog:

* Generated config files: `/tmp/datadog/` (Mounted on dd-agent and dockgen  container)
    - Datadog container dest: `/etc/dd-agent/conf.d/`
    - Dockgen conatiner dest: `/etc/dd-agent/conf.d/`

#### Dock-gen datadog:

* Main config file: `/home/core/config/dockgen/datadog/docker-gen.cfg`
    - Dock-gen datadog dest: `/etc/docker-gen/docker-gen.cfg`
* Templates: `/home/core/templates/datadog/`
    - Dock-gen datadog dest: `/etc/docker-gen/templates/`
