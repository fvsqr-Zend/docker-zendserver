Zend Server 9.1 in Docker
============================================
Zend Server 9.1, PHP 7.1, Apache: [![](https://images.microbadger.com/badges/version/janatzend/zend-server:9.1-php7.1-apache.svg)](https://microbadger.com/images/janatzend/zend-server:9.1-php7.1-apache "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/janatzend/zend-server:9.1-php7.1-apache.svg)](https://microbadger.com/images/janatzend/zend-server:9.1-php7.1-apache "Get your own image badge on microbadger.com")

Zend Server 9.1, PHP 7.1, Nginx: [![](https://images.microbadger.com/badges/version/janatzend/zend-server.svg)](https://microbadger.com/images/janatzend/zend-server "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/janatzend/zend-server.svg)](https://microbadger.com/images/janatzend/zend-server "Get your own image badge on microbadger.com")
Run
---
These images are automatically built at docker hub:
```
docker pull janatzend/zend-server:9.1-php7.1-apache
```
```
docker pull janatzend/zend-server:9.1-php7.1-nginx
```

Build
-----
Build your own bootstrapped Docker container for Zend Server with Apache and PHP 7.0.

To build run:
```
docker build -t janatzend/zend-server:9.1-php7.1-apache .
```
or
```
docker build -t janatzend/zend-server:9.1-php7.1-nginx -f Dockerfile.nginx .
```
from within the cloned directory (please note the trailing dot).

To run:
```
docker run -d -P janatzend/zend-server:9.1-php7.1-apache
```
resp.
```
docker run -d -P janatzend/zend-server:9.1-php7.1-nginx
```
This starts the container in a daemonized mode, that means that the container is still available after closing the terminal window.

Docker exposes port 80 and 443 for http(s) and port 10081 and 10082 for Zend Server GUI (http/https). With the flag '-P' Docker maps these container ports to free ports between 49153 to 65535, so that you can access Zend Server and apps by using your host computers IP.

You can also map manually (mandatory for Mac OS X), for example
```
docker run -d -p 88:80 -p 10088:10081 janatzend/zend-server:9.1-php7.1-apache
```
This command redirects port 80 to port 88, and port 10081 (Zend Server UI port) to port 10088. The default web site is then available at ```http://localhost:88```, Zend Server GUI at ```http://localhost:10088```

Internal / Development mode
---------------------------
Only applicable on Linux: If there's no need to expose ports at all, because all you need is an internal dev system which is only available on your personal host, you can also start a container like this:
```
docker run -d janatzend/zend-server:9.1-php7.1-apache
```
or
```
docker run janatzend/zend-server:9.1-php7.1-apache
```
You can access the App and Zend Server UI via the default ports 80, 443, 10081, 10082, but now you have to use the IP address of the container. You can find it in the result of
```
docker inspect <container-id>
```

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

make
----
For your convenience a Makefile has been created. Make is used for simple pulling, building, starting, stopping and removing Docker images resp. containers. In a terminal type ```make```to get all available options. Please note, that this has not been tested on Windows but only on MacOS and Linux.
