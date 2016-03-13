####
# nginx
####

nginx_config_push:
	scp infra/nginx/nginx.conf $(CONNECT):$(NX_CONFIGPATH)
	
nginx_run:
	ssh $(CONNECT) docker run -d -p 80:80 --name $(NX_NAME) -e SERVICE="nginx" -e PROJECT="stage" -e ENVIRONMENT="operations" -v /tmp/nginx:/etc/nginx/conf.d -v $(NX_CONFIGPATH):/etc/nginx/nginx.conf nginx

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

dockgen_nginx_run:
	ssh $(CONNECT) docker run -d- --name $(NGINX_DOCKGEN_NAME) \
	-v /tmp/nginx:/etc/nginx/conf.d \
	-v /var/run/docker.sock:/tmp/docker.sock:ro \
	-v /home/core/templates/nginx/:/etc/docker-gen/templates/ \
	-v /home/core/config/dockgen/nginx/:/etc/docker-gen/config/docker-gen.cfg \
	jwilder/docker-gen -notify-sighup nginx -config /etc/docker-gen/config/docker-gen.cfg

####
# docker-gen-datadog
####

dockgen_datadog_run:
	docker run -d --name $(DATADOG_GEN_NAME) \
	-v /var/run/docker.sock:/tmp/docker.sock:ro \
	-v /tmp/datadog/:/etc/dd-agent/conf.d \
	-v /home/core/templates/datadog/:/etc/docker-gen/templates \
	-v /home/core/config/dockgen/datadog/docker-gen.cfg:/etc/docker-gen/config/docker-gen.cfg \
	-t jwilder/docker-gen \
	-notify-sighup dd-agent -config /etc/docker-gen/config/docker-gen.cfg


####
# datadog
####

datadog_run:
	ssh $(CONNECT) docker run -d --name $(DATADOG_NAME) -h $(HOSTNAME) -v /var/run/docker.sock:/var/run/docker.sock -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -v /opt/dd-agent-conf.d:/conf.d:ro -e API_KEY=$(API_KEY) -e SERVICE="datadog" datadog/docker-dd-agent

datadog_cleanup:
	ssh $(CONNECT) docker stop $(DATADOG_NAME) | xargs -r ssh $(CONNECT) docker rm 

datadog_deploy: datadog_cleanup datadog_run 