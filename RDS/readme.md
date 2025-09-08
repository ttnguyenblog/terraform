# 🧪 Lab Deploying a Basic Web Application on AWS with Terraform

## 📌 Giới thiệu
This lab provides a step-by-step guide to deploying a basic web application on AWS using **Terraform**.  
The system consists of the following core components:  

- **VPC**: a private network containing all resources.  
- **Subnets**: includes **public** and **private**, connected to an **Internet Gateway** and **NAT Gateway**.  
- **Security Groups**: manage access between services. 
- **EC2 Web Servers**: deployed in an **Auto Scaling Group** with a **Launch Configuration**.  
- **RDS Database (Multi-AZ)**: backend storage for the application.  

---

## 🏗️ Deployment Architecture
The overall infrastructure model: 

```
![Architecture](RDS/image/getting-started-mysql.png)

````

---

## ⚙️ Execution Guide

### 1. Login EC2
```bash
ssh -i RDS/keys/my-ec2-key.pem ubuntu@<EC2_PUBLIC_IP>
````

* **username**: `ubuntu`
* **private key**: `RDS/keys/my-ec2-key.pem`

---

### 2. Run Terraform

In the file environments/prod/prod.tfvars, update your Role ARN and Account ID:

### Role_arn and allowed_account_ids Configuration
role_arn            = "arn:aws:iam::891612588944:role/admin"
allowed_account_ids = ["891612588944"]

⚠️ Note: Replace **891612588944** with your AWS Account ID, and role/admin with an IAM Role that has administrator permissions.

```bash
cd rds

# Initialize Terraform
terraform init

# Create environment directory
mkdir -p prod

# Generate deployment plan
terraform plan -var-file="environments/prod/prod.tfvars" -no-color -out="prod/tf.plan"

# Apply the deployment
terraform apply prod/tf.plan
```

---

### 3. Destroy Infrastructure

```bash
terraform destroy -var-file="environments/prod/prod.tfvars" -auto-approve
```

---

## Application Deployment

```bash
# ========================
# 1. Install MySQL Server
# ========================
sudo apt update -y
sudo apt install -y wget lsb-release gnupg

# Add MySQL APT repository
wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.32-1_all.deb

# Update package
sudo apt update -y

# Install MySQL server
sudo apt install -y mysql-server

# Start MySQL server
sudo systemctl start mysql

# Enable MySQL
sudo systemctl enable mysql

# Check version
mysql -V

# Connect to MySQL and create a new database (you might want to add specific SQL commands here)
mysql -h $DB_HOST -P 3306 -u $DB_USER -p
# Example: mysql -h first-cloud-db-instance.cnk2iquwom9q.ap-southeast-1.rds.amazonaws.com -P 3306 -u admin -p


CREATE DATABASE IF NOT EXISTS first_cloud_users;
USE first_cloud_users;

CREATE TABLE `user`
(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `phone` VARCHAR(15) NOT NULL,
    `comments` TEXT NOT NULL,
    `status` ENUM('active', 'inactive') NOT NULL DEFAULT 'active'
) ENGINE = InnoDB;


INSERT INTO `user`
(`first_name`, `last_name`, `email`, `phone`, `comments`, `status`)
VALUES
('Amanda', 'Nunes', 'anunes@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Alexander', 'Volkanovski', 'avolkanovski@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Khabib', 'Nurmagomedov', 'knurmagomedov@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Kamaru', 'Usman', 'kusman@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Israel', 'Adesanya', 'iadesanya@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Henry', 'Cejudo', 'hcejudo@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Valentina', 'Shevchenko', 'vshevchenko@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Tyron', 'Woodley', 'twoodley@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Rose', 'Namajunas', 'rnamajunas@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Tony', 'Ferguson', 'tferguson@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Jorge', 'Masvidal', 'jmasvidal@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Nate', 'Diaz', 'ndiaz@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Conor', 'McGregor', 'cmcGregor@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Cris', 'Cyborg', 'ccyborg@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Tecia', 'Torres', 'ttorres@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Ronda', 'Rousey', 'rrousey@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Holly', 'Holm', 'hholm@ufc.com', '012345 678910', 'I love AWS FCJ', 'active'),
('Joanna', 'Jedrzejczyk', 'jjedrzejczyk@ufc.com', '012345 678910', 'I love AWS FCJ', 'active');


SHOW DATABASES;
USE database_name;
SHOW TABLES;
SHOW TABLES;
DESCRIBE table_name;

# ========================
# 3. Update hệ thống & Git
# ========================
sudo apt upgrade -y
sudo apt install -y git

# Kiểm tra version Git
git --version

# Clone repo
git clone https://github.com/ttnguyenblog/aws-rds.git
cd aws-rds

# Check if NVM is installed
if ! command -v nvm &> /dev/null; then
  # Step 1: Install nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  source ~/.nvm/nvm.sh
fi

# Verify nvm installation
nvm --version

# Install the LTS version of Node.js
nvm install --lts

# Use the installed LTS version
nvm use --lts

# Verify Node.js and npm installation
node -v
npm -v

# Step 4: Create package.json file (if it doesn't exist yet)
if [ ! -f package.json ]; then
  npm init -y
  echo -e **${GREEN}Created file package.json.${NC}**
fi

#Step 5: Install necessary npm packages
echo -e **Installing required npm packages...**
npm install express dotenv express-handlebars body-parser mysql

#Step 6: Install nodemon as a development dependency
echo -e **Installing nodemon as a development dependency...**
npm install --save-dev nodemon
npm install -g nodemon

# Step 7: Add npm start script to package.json
if ! grep -q '**start**:' package.json; then
  npm set-script start **index.js** # Replace **your-app.js** with your entry point file
  echo -e **${GREEN}Added npm start script to package.json.${NC}**
fi

echo -e **${GREEN}Installation completed. You can now start building and running your Node.js application using 'npm start'.${NC}**



#Config file .env
vi .env

DB_HOST=Endpoint RDS
DB_NAME=Database Name
DB_USER=admin
DB_PASS='Password DB'

# DB_HOST=first-cloud-db-instance.cnk2iquwom9q.ap-southeast-1.rds.amazonaws.com
# DB_NAME=first_cloud_users
# DB_USER=admin
# DB_PASS='Password DB'

# Run app
npm start

#Test the application in the browser

http://<ip>:5000
```
