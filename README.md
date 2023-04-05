# Kafka Cluster on AWS EC2

- [Introduction to Kafka](https://medium.com/@sunnykkc13/introduction-to-kafka-2f274f922c17)
- [Kafka local setup](https://medium.com/@sunnykkc13/kafka-setup-91b33fb50c86)

## prerequisite/Dev Environment Setup

- AWS account
- Access and Secret key of the account you want to use.
- [AWS CLI](https://awscli.amazonaws.com/AWSCLIV2.msi)
- configure the aws cli with access and secret key `aws configure` on terminal editor.
- [terraform binary](https://www.terraform.io/downloads)
- add terraform path into environment variable to have global access.
- terraform will use your aws credential to talk to AWS.

## Getting Started

- clone this repository.

```
git clone https://github.com/navsin189/kafka-aws-cluster.git

cd kafka-aws-cluster

terraform init
```

- `init` initialize the directory.

- **Note** - a file named `secrets.tfvars` needs to be created under `kafka-aws-cluster` directory.
- it will hold two sensitive value mentioned
  - key_name = "key name used to SSH on EC2 instance"
  - key_name_path = "key path in your local system"

```
terraform plan -var-file="secrets.tfvars"
# it will provide you the list of changes that are going to be create/change/destroy
```

- **if everything seems correct, we can move forward and start creating the resources**

```
terraform apply -var-file="secrets.tfvars"
# it will start creating the resources
# due to sensitive data that are present in other tf files so we have to pass like this.
# In this case we have it so you have to run like this
```

- Then it will also show you **terraform plan** output and ask for validation either **yes** or **no**.
- enter **yes** and just wait.
- as soon as the task gets completed, **the public IP would be available on the terminal itself**.
- On terminal, public IP will be provided after completion
- login to ec2-instance using IP and key. `ssh -o ServerAliveInterval=60 -i key.pem ec2-user@IP`
- run the following commands

```
# on zookeeper
# just to ensure the server has started
netstart -tlnup | grep 2181
ps aux | grep zookeeper

# on broker
netstart -tlnup | grep 9092
ps aux | grep server
```

- if not run the startup_command script again.

- to check whether broker is connected to zookeeper or not

```
/home/ec2-user/kafka_2.13-3.4.0bin/zookeeper-shell.sh localhost:2181

# then
ls /brokers/ids
```

## Start/Stop AWS EC2 Instance

```
aws ec2 describe-instances #give you the list of instances on specified zone

aws ec2 describe-instances --instance-id "id of your instance" #detail of particular instance
```

- [describe-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html)

```
aws ec2 start-instances --instance-id "id of your instance" # start a particular instance
aws ec2 start-instances --instance-ids "instance1" "instance2" ... #start multiple instances
```

- [start-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/start-instances.html)

```
aws ec2 stop-instances --instance-id "id of your instance" # stop a particular instance
aws ec2 stop-instances --instance-ids "instance1" "instance2" ... #stop multiple instances
```

- [stop-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/stop-instances.html)

## Limitation(As of now)

- Not able to launch multiple EC2 instances from single module because each broker should have unique ID and for now broker id is set to 1.
- Sometime server gets crashed on its own so need to start it manually through startup_command script.

> Limitation would be addressed in future
