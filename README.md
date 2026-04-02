# AWS Multi-AZ Infrastructure Deployment

Terraform configuration for a secure, highly-available two-tier AWS architecture.

## Overview
<img width="1136" height="606" alt="diagram-export-02-04-2026-14_09_12" src="https://github.com/user-attachments/assets/b55fab65-2a6f-4254-8fda-e3f0d01b6742" />

This project automatically provisions a structured AWS environment featuring isolated networking, a public compute layer, and a private database layer.

### Core Components
* **Networking**: Custom VPC (`10.0.0.0/16`) with a managed Internet Gateway.
* **Public Tier**: Compute subnet (`us-east-1a`) hosting an Amazon Linux 2 EC2 instance (bastion host).
* **Private Tier**: Multi-AZ subnet group (`us-east-1a`, `us-east-1b`) hosting a managed Amazon RDS MySQL instance.
* **Security Constraints**: Inbound EC2 access restricted to standard SSH. RDS access strictly limited to queries originating from the EC2 security group.

## Infrastructure Map

* `vpc.tf` — Core networking (VPC, Subnets, IGW, Routing)
* `sg.tf` — Access control barriers (Security Groups)
* `ec2.tf` — Public compute provisioning 
* `rds.tf` — Private relational database deployment
* `variables.tf` — Input variables for secure credentials
* `outputs.tf` — Infrastructure endpoint tracking

## Usage

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Deploy Configuration:**
   Provide the required variables (such as the database password) directly via the CLI, or by creating a local `terraform.tfvars` file:
   ```bash
   terraform apply -var="db_password=YourSecurePassword!"
   ```

3. **Verify Connection:**
   ```bash
   # SSH to Bastion Host
   ssh -i "lab7-key" ec2-user@<EC2_PUBLIC_IP>
   
   # Connect to Private Database
   sudo yum install -y mysql
   mysql -h <RDS_ENDPOINT> -P 3306 -u admin -pYourSecurePassword!
   ```

4. **Resource Teardown:**
   ```bash
   terraform destroy
   ```
