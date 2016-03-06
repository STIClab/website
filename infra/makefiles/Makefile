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
# dockgen-nginx
####

####
# 
####