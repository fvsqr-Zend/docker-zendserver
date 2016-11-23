# Noise-Generator
Guide for starting a 3-node cluster running Magento with a set of pre-defined events

## Step 1 - Starting the engines
Call
```
make docker-build
```
in order to create the necessary docker containers.
Start them by calling
```
make up
```
As it takes some time to start the Zend Server container, one can check the current status with:
```
make systeminfo
```
After Zend Server has booted up, Chrome users in Linux can run
```
make open-zs
```
to open a new tab in the browser with the Zend Server GUI. You can now log in to the displayed URL with admin/admin.
If ```open-zs``` is not working, call
```
make docker-info
```
to get the IP address of the Zend Server container. UI is available at ```http://<IP>:10081```

## Step 2 - application
Step 2a, 2b and 2c can be executed in individual order.
### Step 2a - scaling
Call
```
make scale ZS=3
```
in order to start two additional nodes, which are automatically added to the cluster created in step 1. Please note that the cluster can be scaled to a different number than 3, but the pre-generated Monitoring data (Step 3) has been build for 3 nodes.
### Step 2b - deploying
Call
```
make deploy
```
to deploy the application to the system.
### Step 2c - Z-Ray
In a docker setup with dynamic networking, Z-Ray needs to get the IP address of one server written to a directive. This can be achieved by calling
```
make zray
```
## Step 3
Call
```
make eventdata-init
```
in order to add pre-generated Monitoring data for displaying several Monitoring events, long-term trending charts and URL-insight information.
The event data is only showing data from the last two hours, so please make sure to activate the "last 2 hours" filter in all the pages. You will also see that there is half an hour of "future" data. This allows you to have enough preparation time for a demo and/or you see some movement in the graphs even during the demo.
### Step 3b
If you have generated the data more than two hours before a demo, you do not have to re-do step 3, but just call
```
make eventdata-update
```
It will reset the first event item from now minus two hours.
### Step 3c
For your convenience several targets have been created to use the Zend Server WebAPI in order to fetch monitoring, statistics and URL insight data. Call
```
make help
```
and search for targets starting with ```zs-get``` to see all the available commands. 
