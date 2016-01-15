# Noise-Generator
Guide for starting a 3-node cluster running Magento with a set of pre-defined events

## Step 1
Call
```
# ./start_cluster_zs_8.5_php5.6_apache.sh
```
in order to start the Loadbalancer, a Zend Server instance and a MySQL DB Server. Zend Server is automatically creating a new cluster setup and is being added as the first node. Please wait for the message:
'Zend Server is ready for use'
You can now log in to the displayed URL with admin/admin
## Step 2
Call 
```
# ./scale_cluster_zs_8.5_php5.6_apache.sh 3
```
in order to start two additional nodes, which are automatically added to the cluster created in step 1. Please note that the cluster can be scaled to a different number than 3, but the pre-generated Monitoring data (Step 3) has been build for 3 nodes.
## Step 3
Call 
```
# ./makenoise_magento.sh
```
in order to install Magento in the cluster and add pre-generated Monitoring data for displaying several Monitoring events, long-term trending charts and URL-insight information.
The event data is only showing data from the last two hours, so please make sure to activate the "last 2 hours" filter in all the pages. You will also see that there is half an hour of "future" data. This allows you to have ebough preparattion time for a demo and/or you see some movement in the graphs even during the demo.
### Step 3b
If you have generated the data more than two hours before a demo, you do not have to restart the whole process, but just call
```
# ./makenoise_magento.sh update
```
It will reset the first event item from now minus two hours.
