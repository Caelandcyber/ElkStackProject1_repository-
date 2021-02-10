# ElkStackProject1_repository-
The repository holds everything that involved with the deployment of my Azure Cloud network's RedTeam_artifacts and Elk_Vnet virtual networks in peer with one another.

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO](Images/Peer NetworkRedTeam_Elk-Diagram Network.jpg)

ElkStackProject1_repository-/Diagrams/Peer NetworkRedTeam_Elk-Diagram Network.jpg

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the 'playbook.yml' file may be used to install only certain pieces of it, such as Filebeat.

  - filebeat-playbook.yml         metricbeat-playbook.yml  

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

What aspect of security do load balancers protect? What is the advantage of a jumpbox?
Load balancers make sure there is availabilty to the network no matter size or volume of traffic, it distributes it evenly.  The up side to a jumpbox is you have an access point to all the administrative containers in your network to all vm's.  

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
 What does Filebeat watch for?  Filebat watches log files and locations to collect events to be forwarded to elacstic search and log stash.
 What does Metricbeat record?  Collects metric data from services running on sever and opterting system.  The data can then be sent to elesticsearch and logstash.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function         | IP Address | Operating System   |
|----------|------------------|------------|--------------------|
| Jump Box | Gateway          | 10.0.0.4   | Linux Ubuntu 18.04 |
| Web-1    | docker-DVWA      | 10.0.0.7   | Linux Ubuntu 18.04 |
| Web-2    | docker-DVWA      | 10.0.0.8   | Linux Ubuntu 18.04 |
| Web-3    | docker-DVWA      | 10.0.0.9   | Linux Ubuntu 18.04 |
| ElkVM1   | Elkstack-Kibanna | 10.1.0.4   | Linux Ubuntu 10.04 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Personal local machines IP address.

Machines within the network can only be accessed by jumpbox.
- Which machine did you allow to access your ELK VM? JumpBoxProvisioner. 
- What was its IP address?  10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses  |
|----------|---------------------|-----------------------|
| Jump Box | No                  | Local Machine IP Only |
| Web-1    | No                  | 10.0.0.4              |
| Web-2    | No                  | 10.0.0.4              |
| Web-3    | No                  | 10.0.0.4              |
| ElkVM1   | No                  | 10.0.0.4              |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- the main reason for using Ansible via plabooks is the ease or use configuring other machines instead of configuring them manually.  Makes the process much more stream line, and allows new vm's to be created through single commands.

The playbook implements the following tasks:
- Creates a simple named new VM (make a note of private IP used to SSH into VM and the public IP used to log into Kibanna for uploaded data)
- Automatically downloads the new elk-docker container. Inside /etc/ansible/hosts you will add a new group [elk] the private IP (10.1.0.4) to the group, then create a new ansible-playbook that will download, install, configures "ElkVM1" to map ports [5601,9200], and then it will start the container.
- Launches and exposes the container. Once the contianer has been installed and started, you can then verify that the container is deployed and running by simply using SSH to connect and attach to the container from your JumpBoxProvisioner. Once you are in the ElkVM1 run 'sudo docker ps'
- Creates inbound security rules to allow Ports: 5601 and 9200 "The Inbound Security Rules should allow access from your local machines personal networ.
- Open browser and type in the [Local Machines Public IP:5601] to access the Kibana Portal Page to allow you to upload data logs.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- ElkVM1 - 10.1.0.4

We have installed the following Beats on these machines:
- filebeat /  metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is a lightweight data shipper for storing log data in one place and then forwarding the log data. It monitors log files/locations you specify, collects log events, and sends them as output either to Elasticsearch or Logstash. Metricbeat gathers metrics from the operating system and from running services on network server. Metricbeat then takes this informataional data/ statistical data that it collected and ships them to an output specified. Metricbeat log example- Active Connections [Metricbeat Nginx]ECS

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-playbook.yml file to /etc/ansible/roles .
- Update the filebeat-config.yml file to include your Private Ip address. Paths to both are /etc/ansible/files/filebeat-config.yml  /etc/ansible/files/filebeat-config.yml.  Then you need to locate          output.elasticsearch and setup.kibana and and fix the ip address to your own.
- Run the playbook, and navigate to kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
Which file is the playbook? Where do you copy it?_ 
- The file name for the playbook is [filebeat-playbook.yml] it is located at /etc/ansible/roles/filebeat-playbook.yml

Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_  
- You need to update the filebeat.yml, it is a configuration file that drops into the ElkVM1 when the ansible playbook is run on the commandline.  You also need to update the host.cfg with a new group called 'elk' and add the private IP address of the ElkVM1 to thelie underneath the new group name elk.  After this, you need to nano into your filebeat.yml to edit and configure it to now represent the private IP of the ElkVM1 as well.

Which URL do you navigate to in order to check that the ELK server is running? 
- You navigate to the URL  http://[ElkVM1.Public.IP]:5601/app/kibana   My personal VM IP was 40.69.143.160


The commands you will need to run the playbook's are:
- ssh RedAdmin@JumpBox(10.1.0.4)     -10.1.0.4=ElkVM1 private ip-
- sudo docker container list -a 
          (locate your ansible container, for our network the container name is e4ce2dff301d)
- sudo docker start [container name] 
- sudo docker attach [container name]
- cd /etc/ansible/
- install-elk.yml (configures ElkVM1 and starts the elk container) shouldn't take more than a few minutes for the deployment/activation/implementation of the elk.
- cd /etc/ansible/roles/
- then run the command 'ansible-playbook filebeat-playbook.yml' (installs Filebeat)   for metric beat run 'ansible-playbook metricbeat-playbook.yml (installs Metricbeat)
- In a web browser tab navigate to this kibana web page with the following URL template.  http://40.69.143.160:5601/app/kibana     -40.69.143.260 being the private IP address of the ElkVM1- 
-If seccuesfully deployed you should now be able to load your log data from the ansible containers you have deployed with ELk.
