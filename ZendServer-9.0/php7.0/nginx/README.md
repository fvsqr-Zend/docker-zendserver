Zend Server 9.0 in Docker
============================================
Run
---
The image is automatically built at docker hub:
```
docker pull janatzend/zend-server:9.0-php7.0-nginx
```

Build
-----
Build your own bootstrapped Docker container for Zend Server with Nginx and PHP 7.0.

To build run:
```
docker build -t janatzend/zend-server:9.0-php7.0-nginx .
```
from within the cloned directory (please note the trailing dot).

To run:
```
docker run -d -P janatzend/zend-server:9.0-php7.0-nginx
```
This starts the container in a daemonized mode, that means that the container is still available after closing the terminal window.

Docker esposes port 80 and 443 for http(s) and port 10081 and 10082 for Zend Server GUI (http/https). With the flag '-P' Docker maps these container ports to free ports between 49153 to 65535, so that you can access Zend Server and apps by using your host computers IP. 

You can also map manually, for example
```
docker run -d -p 88:80 -p 10088:10081 janatzend/zend-server:9.0-php7.0-nginx
```
This command redirects port 80 to port 88, and port 10081 (Zend Server UI port) to port 10088.

Internal / Development mode
---------------------------
If there's no need to expose ports at all, beacuse all you need is an internal dev system which is only available on your personal host, you can also start a container like this:
```
docker run -d janatzend/zend-server:9.0-php7.0-nginx
```
or
```
docker run janatzend/zend-server:9.0-php7.0-nginx
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
The default password for accessing the GUI with the admin user is 'admin'. If the password should be changed during the start of the conatiner, the environment var ZS_ADMIN_PASSWORD can be added with the -e flag.
There is also some output from Zend Server after bootstrapping - for example the password for the UI. If you're not running in damonized mode, you'll get the output directly in the terminal. Otherwise you have to execute:
```
docker logs <container-id>
```
Please note that it can take some time to bootstrap and configure Zend Server - so please be patient and repeat the command if you don't get the Zend Server URL and password immediately.

Cluster
-------
To start a Zend Server cluster, use `docker-compose`. You can find a docker-compose.yml file in the repository. It will start a Load Balancer container , a MySQL container and Zend Server.
The Zend Server container can be scaled by calling for example
```
docker-compose scale zendserver=3
```
The load balancer will automatically reconfigure, so that the website with all started applicaton servers is reachable at `http://localhost:8888`. The Zend Server GUI URL is echoed to the logs of the Zend Server container.
Another note: One Zend Server instance a.k.a. Zend Server Container is consuming round about 500M of memory, so please chose the number of nodes to be started wisely...
