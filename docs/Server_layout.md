# Server layout

### apache container

* auto managed
* config file push with `make apache_config_push`

### nginx load balancer (manual setup)

* manual setup
    * make nginx_deploy
* config file push with `make nginx_config_push`

#### dock-gen for auto generate nginx config file

* manual setup
    * make dockgen_nginx_deploy
* config file pushed with `make dockgen_nginx_config_push`
* templates updated with `make update_dockgen_nginx_templates`

### datadog monitoring agent

* manual setup
	* make datadog_deploy

#### dock-gen for auto generating datadog yml files

* manual setup
    * make dockgen_datadog_deploy
* config file pushed with `make dockgen_datadog_config_push`
* templates updated with `make update_dockgen_datadog_templates`