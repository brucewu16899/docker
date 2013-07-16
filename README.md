Installation using Vagrant
-------------------------

Both virtualbox and AWS is supported. AWS needs some special setup, see below.

```
# Start VM
vagrant up vb|aws

# Login
vagrant ssh vb|aws

# Shutdown VM
vagrant halt vb|aws

# Remove VM
vagrant destroy vb|aws
```

NOTE: `vagrant reload vb|aws` don't seam to work. Use `vagrant destroy vb|aws && vagrant up vb|aws` instead.


See http://docs.vagrantup.com for more details


## In VirtualBox

```
# List machines
VBoxManage list vms

# List running machines
VBoxManage list runningvms
```


## AWS EC2

Setup for AWS EC2:

```
# Install AWS plusin
vagrant plugin install vagrant-aws
vagrant plugin list

# A dummy box is needed
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box

# Set this variable to use AWS, it should bot be set to use a local Virtualbox instead
export VAGRANT_AWS='Yes'

# These environment variables need to be set, put in bashrc/bach_profile env 
# NOTE: Only the region us-east-1 seams to work at the moment.
export AWS_API_KEY=...
export AWS_API_SECRET=...
export AWS_PRIVATE_KEY_PATH=...
export AWS_KEYAIR_NAME=...
export AWS_REGION=...

vagrant up aws
```

NOTE: A kernel upgrade will be performed on the the first boot. In case of problems
in this upgrade, just do `vagrant up` once more to start the vm. `uname -r` should
say 3.2.0.23


For more details see:  https://github.com/mitchellh/vagrant-aws


Docker
-----

Once the VM is up and running, these docker commands will get you started.
See http://docker.io for more details.


```
# List images
docker images

# List running containers
docker ps

# List all containers
docker ps -a

# create a new container and connect. ID could be base etc.
docker run -i -t [ID] /bin/bash

# Create ubuntu image from local tar (in case there is network connectivity to the docker registry)
cp /vagrant/ubuntu.tar.gz
gunzip ubuntu.tar.gz
cat ubuntu.tar | docker import - my_ubuntu 

# Check ID of image just created
docker images

# Create container using the image
docker run -i -t [ID] /bin/bash
```

NOTE: Exit a docker container with ctrl-p ctrl+q if you don't want to shut it down!


## Docker images

Images can be imoported and exported. My images are saved in Amazon S3 (they are to big to save in git).
The images are gound here: s3://gizur-docker


