Zend Server  in Docker
============================================
Zend Server , PHP 7.2, Apache:

[![](https://images.microbadger.com/badges/version/janatzend/zend-server:2018.1.ea2-php7.2-apache.svg)](https://microbadger.com/images/janatzend/zend-server:2018.1.ea2-php7.2-apache "Zend Server 2018.1 EA2, PHP 7.2, Apache") [![](https://images.microbadger.com/badges/image/janatzend/zend-server:2018.1.ea2-php7.2-apache.svg)](https://microbadger.com/images/janatzend/zend-server:2018.1.ea2-php7.2-apache "Zend Server 2018.1 EA2, PHP 7.2, Apache")

Zend Server , PHP 7.2, Apache-FPM:

[![](https://images.microbadger.com/badges/version/janatzend/zend-server:2018.1.ea2-php7.2-apache-fpm.svg)](https://microbadger.com/images/janatzend/zend-server:2018.1.ea2-php7.2-apache-fpm "Zend Server 2018.1 EA2, PHP 7.2, Apache-FPM") [![](https://images.microbadger.com/badges/image/janatzend/zend-server:2018.1.ea2-php7.2-apache-fpm.svg)](https://microbadger.com/images/janatzend/zend-server:2018.1.ea2-php7.2-apache-fpm "Zend Server 2018.1 EA2, PHP 7.2, Apache-FPM")

Zend Server , PHP 7.2, Nginx:

[![](https://images.microbadger.com/badges/version/janatzend/zend-server:2018.1.ea2-php7.2-nginx.svg)](https://microbadger.com/images/janatzend/zend-server:2018.1.ea2-php7.2-nginx "Zend Server 2018.1 EA2, PHP 7.2, Nginx") [![](https://images.microbadger.com/badges/image/janatzend/zend-server:2018.1.ea2-php7.2-nginx.svg)](https://microbadger.com/images/janatzend/zend-server:2018.1.ea2-php7.2-nginx "Zend Server 2018.1 EA2, PHP 7.2, Nginx")

make
----
For your convenience a Makefile is available. Make is used for pulling, building, starting, stopping and removing Docker images resp. containers. Clone the repository ```https://github.com/janatzend/docker-zendserver.git``` and run ```make``` in the ```./ZendServer-2018.1EA2``` directory to get all available options. Please note, that this has not been tested on Windows but only on MacOS and Linux.

### Ports
All ```make``` commands are using docker-compose. In order to define the ports of the app, Zend Server UI and some more, the ```.env``` file can be modified. This environment file is being used in the ```docker-compose.*.yml``` files.

Run
---
These images are automatically built at docker hub:
```
docker pull janatzend/zend-server:2018.1.ea2-php7.2-apache
```
```
docker pull janatzend/zend-server:2018.1.ea2-php7.2-nginx
```

Build
-----
Build your own bootstrapped Docker container for Zend Server with Apache, Apache FPM or Nginx and PHP 7.2.

To build run:
```
docker build -t janatzend/zend-server:2018.1.ea2-php7.2-apache .
```
or
```
docker build -t janatzend/zend-server:2018.1.ea2-php7.2-apache-fpm -f Dockerfile.apache-fpm .
```
or
```
docker build -t janatzend/zend-server:2018.1.ea2-php7.2-nginx -f Dockerfile.nginx .
```
from within the cloned directory (please note the trailing dot).

To run:
```
docker run -d -P janatzend/zend-server:2018.1.ea2-php7.2-apache
```
resp.
```
docker run -d -P janatzend/zend-server:2018.1.ea2-php7.2-apache-fpm
```
resp.
```
docker run -d -P janatzend/zend-server:2018.1.ea2-php7.2-nginx
```
This starts the container in a daemonized mode, that means that the container is still available after closing the terminal window.

Docker exposes port 80 and 443 for http(s) and port 10081 and 10082 for Zend Server GUI (http/https). With the flag '-P' Docker maps these container ports to free ports between 49153 to 65535, so that you can access Zend Server and apps by using your host computers IP.

You can also map manually (mandatory for Mac OS X), for example
```
docker run -d -p 88:80 -p 10088:10081 janatzend/zend-server:2018.1.ea2-php7.2-apache
```
This command maps port 88 on localhost to port 80 in the container, and port 10088 on localhost to port 10081 in the container (Zend Server UI port). The default web site is then available at ```http://localhost:88```, Zend Server GUI at ```http://localhost:10088```

Internal / Development mode
---------------------------
Only applicable on Linux: If there's no need to expose ports at all, because all you need is an internal dev system which is only available on your personal host, you can also start a container like this:
```
docker run -d janatzend/zend-server:2018.1.ea2-php7.2-apache
```
or
```
docker run janatzend/zend-server:2018.1.ea2-php7.2-apache
```
You can access the App and Zend Server UI via the default ports 80, 443, 10081, 10082, but now you have to use the IP address of the container. You can find it in the result of
```
docker inspect <container-id>
```

### Loading PHP app from Host system
If there is already a PHP app available locally on the host system, it can be easily added to the container. E.g.
```
docker run -d \
  -v $PWD/www:/var/www/html \
  -p 88:80 \
  -p 10088:10081 \
  janatzend/zend-server:2018.1.ea2-php7.2-nginx
```
mounts the ```www``` folder from the current working directory into the pre-defined document root from Apache or Nginx. The app can then be accessed by calling ```http://localhost:88```.

Open Zend Server GUI
-----
If you're using "-P" flag, you can check the App and Zend Server ports with
```
docker ps
```
Otherwise you should know which ports you have set yourself ;)

Then open your browser at
```
http://localhost:PORT_MAP_10081
```
or
```
https://localhost:PORT_MAP_10082
```
The default password for accessing the GUI with the admin user is 'admin'.
There is also some output from Zend Server after bootstrapping. If you're not running in daemonized mode, you'll get the output directly in the terminal. Otherwise you have to execute:
```
docker logs <container-id>
```
Please note that it can take some time to bootstrap and configure Zend Server - so please be patient.

Cluster
-------
To start a Zend Server cluster, use `docker-compose`. You can find a docker-compose.yml file in the repository. It will start a Load Balancer container, a MySQL container and Zend Server.
By default the load balancer is listening on localhost port 80. If there is another service running on port 80 on the host system (or another container service is mapped to port 80), the port mapping of the load balancer has to be modified in the docker-compose.yml file.
The setup can be started with the command
```
docker-compose up
```
The Zend Server container can be scaled by calling for example
```
docker-compose scale zendserver=3
```
The load balancer will automatically reconfigure, so that the website with all started application servers is reachable at `http://localhost:80`.
Another note: One Zend Server instance a.k.a. Zend Server Container is consuming round about 500M of memory, so please chose the number of nodes to be started wisely...

Database
--------
When using either the docker-compose files or make to start a Zend Server environment, a MySQL database is automatically started in a dedicated container. This database server is used for Zend Server to store monitoring information, configuration data and in general cluster data - even if only one Zend Server node is being used.
However, this database can also be used as the application database. For example, the Zend Server deployment feature allows you to install test applications from within the Zend Server UI, e.g. Drupal, Wordpress, Magento and more. Most of these applications need a database to work. The database credentials have to be entered during the deployment process. By default these are:
```
DB host: DB
DB port: 3306
DB user: root
DB pass: admin
```   
