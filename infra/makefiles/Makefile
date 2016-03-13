NX_NAME=nginx
NX_MAIN_CONFIG_SRC=/home/core/config/nginx/nginx.conf
NX_MAIN_CONFIG_DEST=/etc/nginx/nginx.conf
NX_GEN_CONFIG_SRC=/tmp/nginx/
NX_GEN_CONFIG_DEST=/etc/nginx/conf.d/

DOCKGEN_NX_NAME=docker-gen-nginx
DOCKGEN_NX_TMLP_SRC=/home/core/templates/nginx/
DOCKGEN_NX_TMPL_DEST=/etc/docker-gen/templates/
DOCKGEN_NX_CFG_SRC=/home/core/config/dockgen/nginx/docker-gen.cfg
DOCKGEN_NX_CFG_DEST=/etc/docker-gen/config/docker-gen.cfg

AP_MAIN_CONFIGPATH=/home/core/config/apache/httpd.conf

# full ssh connect vars
CONNECT = $(REMOTE_USER_NAME)@$(IP)

####
# ssh
####

ssh:
	ssh $(CONNECT)

####
# nginx
####

nginx_config_push:
	scp ../nginx/nginx.conf $(CONNECT):$(NX_MAIN_CONFIG_SRC)
	
nginx_run:
	ssh $(CONNECT) docker run -d -p 80:80 --name $(NX_NAME) \
	-e SERVICE="nginx" -e PROJECT="stage" -e ENVIRONMENT="operations" \
	-v $(NX_GEN_CONFIG_SRC):$(NX_GEN_CONFIG_DEST)\
	-v $(NX_MAIN_CONFIG_SRC):$(NX_MAIN_CONFIG_DEST) \
	nginx

nginx_cleanup:
	ssh $(CONNECT) docker stop $(NX_NAME)
	ssh $(CONNECT) docker rm $(NX_NAME)

####
# apache
####

apache_config_push:
	scp infra/apache/ $(CONNECT):$(AP_CONFIGPATH)

####
# docker-gen-nginx
####

dockgen_nginx_config_push:
	scp ../dockgen/nginx/docker-gen.cfg $(CONNECT):$(DOCKGEN_NX_CFG_SRC)

dockgen_nginx_template_push:
	scp ../dockgen/nginx/*.tmpl $(CONNECT):$(DOCKGEN_NX_TMLP_SRC)

dockgen_nginx_run:
	ssh $(CONNECT) docker run -d- --name $(DOCKGEN_NX_NAME) \
	-v /tmp/nginx:/etc/nginx/conf.d \
	-v /var/run/docker.sock:/tmp/docker.sock:ro \
	-v $(DOCKGEN_NX_TMLP_SRC):$(DOCKGEN_NX_TMPL_DEST) \
	-v $(DOCKGEN_NX_CFG_SRC):$(DOCKGEN_NX_CFG_DEST) \
	jwilder/docker-gen -notify-sighup nginx -config /etc/docker-gen/config/docker-gen.cfg

dockgen_nginx_cleanup:
	ssh $(CONNECT) docker stop $(DOCKGEN_NX_NAME)
	ssh $(CONNECT) docker rm $(DOCKGEN_NX_NAME)