#####
# test deploy
####

ifndef MK_CONFIG
$(info MK_CONFIG is not defined)
else
include $(MK_CONFIG)/ssh.cfg
include $(MK_CONFIG)/container.cfg
include $(MK_CONFIG)/deploy.cfg
endif


####
# concatenate vars
####

# full image name
IMAGE = $(IMAGE_NAME):$(IMAGE_VERSION)
# full ssh connect vars
CONNECT = $(REMOTE_USER_NAME)@$(IP)
#virtual hosts
ifdef VIRTUAL_HOST
E_VIRTUAL_HOST= -e VIRTUAL_HOST=$(VIRTUAL_HOST)
endif

####
# Make commands
####


echo_test:
	echo $(REMOTE_USER_NAME)

docker_build:
	docker build -t $(IMAGE) -f $(DOCKERFILEPATH) .

docker_run:
	docker run -d -p  $(PORTHOST):$(PORTGUEST) $(IMAGE); sleep 10

docker_curltest:
	curl --retry 10 --retry-delay 5 -v http://localhost:$(PORTHOST)

docker_save:
	docker save -o $(TARNAME) $(IMAGE)

s3_config:
	echo "[default]" > ~/.s3cfg
	echo "access_key=$(S3_ACCESS_KEY)" >> ~/.s3cfg
	echo "secret_key=$(S3_SECRET_KEY)" >> ~/.s3cfg

s3_upload:
	s3cmd del s3://$(S3_BUCKET)/images/$(TARNAME)
	s3cmd put $(TARNAME) s3://$(S3_BUCKET)/images/$(TARNAME)

remote_s3_download:
	ssh $(CONNECT) AWS_ACCESS_KEY_ID=$(S3_ACCESS_KEY) AWS_SECRET_ACCESS_KEY=$(S3_SECRET_KEY) ./gof3r cp --no-md5 --endpoint=s3-eu-west-1.amazonaws.com s3://$(S3_BUCKET)/images/$(TARNAME) /home/core/$(TARNAME)
	ssh $(CONNECT) docker load -i $(TARNAME)

docker_remove_containers:
	ssh $(CONNECT) docker ps -qa --filter="name=$(CONTAINER)" | xargs -r ssh $(CONNECT) docker stop | xargs -r ssh $(CONNECT) docker rm

docker_remove_images:
	ssh $(CONNECT) docker images -q --filter "dangling=true" | xargs -r ssh $(CONNECT) docker rmi

docker_loop_cleanup: docker_remove_containers docker_remove_images	

docker_loop_deploy:
	for i in `seq 1 $(HOSTS)`; do  ssh $(CONNECT) docker run -d --name $(CONTAINER)$$i --expose $(EXPOSEPORT) -v $(AP_CONFIGPATH):/usr/local/apache2/conf/httpd.conf $(E_VIRTUAL_HOST) $(IMAGE); done;

docker_deploy: remote_s3_download docker_loop_cleanup docker_loop_deploy