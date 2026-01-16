# Watch Me Do This Here: [Migration Lab](https://www.loom.com/share/931978e73c7848a7b94f1d6de5e02308) 

# RiseUp Bank Portal Migration: Azure VM

## Description 🌐
This project involved migrating a customer-facing web application, RiseUp Portal, from a traditional server environment to an Azure Virtual Machine. The migration focused on establishing a stable IaaS-based hosting model in Azure while preserving the application’s existing server-level dependencies and operational behavior.

## Background 📓
RiseUp Bank’s web application was previously hosted on a manually managed server, where deployments, updates, and troubleshooting required direct administrative access. As the application grew, this model introduced operational risk, inconsistent configuration, and limited visibility into system health. The decision was made to migrate the workload into Azure to improve reliability, standardization, and maintainability.

## What is an Azure Virtual Machines? 💻
An Azure Virtual Machines is Microsoft’s Infrastructure-as-a-Service (IaaS) compute offering that provides full operating system control in the cloud. Azure VMs are commonly used for lift-and-shift migrations, legacy workloads, and applications that require custom OS-level configuration. In this project, Azure VMs served as the direct equivalent to an on-prem server or an AWS EC2 instance.

## Challenge ⚠️
The existing hosting environment relied heavily on manual processes. Routine maintenance, application updates, and access management increased the likelihood of configuration drift and unplanned downtime. Performance during traffic fluctuations was inconsistent, and troubleshooting often occurred after service degradation was already visible to users.

## Solution ✅
The RiseUp Portal was migrated to a Linux-based Azure Virtual Machine configured with a standard web server. Network access was restricted using Azure networking controls, and administrative access was secured through SSH key authentication. The application was deployed directly to the VM, enabling the team to retain operational familiarity while benefiting from Azure’s resilient infrastructure.

## Outcome 🏁
After the migration, the application operated from a centralized, cloud-hosted environment with improved stability and reduced operational overhead. Access controls were standardized, the hosting platform became more predictable to manage, and the application maintained consistent performance under normal usage conditions. This migration established a reliable baseline for running server-based workloads in Azure.

### Step 1: Create the Linux Virtual Machine

- Image: Ubuntu Server 24.04 LTS (x64, Gen2)  
- Authentication: SSH public key  
- VM Size: Standard_DS1_v2  
- Inbound ports allowed: 22 (SSH), 80 (HTTP)  
- Trusted Launch enabled  
- VM deployed into an existing virtual network and subnet  

---

### Step 2: Generate an SSH Key Pair (Local Machine)

Run the following command in PowerShell:

`ssh-keygen -t ed25519 -f $env:USERPROFILE\`
`ssh\RiseUp-Migration-Lab -C "RiseUp-Migration-Lab"`

A passphrase is created during this step to protect the private key.

---

### Step 3: Retrieve the Public Key

Get the public key content to paste into Azure during VM creation:

`Get-Content $env:USERPROFILE\.ssh\RiseUp-Migration-Lab.pub`

---

### Step 4: Configure SSH Alias

Create or edit the SSH config file:

`C:\Users\<username>\.ssh\config`

Add the following entry:

Host RiseUp-Portal  
    HostName <VM_PUBLIC_IP>  
    User LabUser  
    IdentityFile C:\Users\<username>\.ssh\RiseUp-Migration-Lab  
    IdentitiesOnly yes

Connect to the VM using:

`ssh RiseUp-Portal`

---

### Step 5: Install and Configure Apache

Once connected to the VM, install Apache:

`sudo apt update` 
`sudo apt install apache2 -y`  
![Apache2](<screenshots/Installing Apache Web Server.jpg>)

Start and enable Apache:

`sudo systemctl start apache2`  
`sudo systemctl enable apache2`  

Verify Apache status: `sudo systemctl status apache2`  

Confirm the default Apache page loads using the VM’s public IP in a browser.


---

### Step 6: Lock Down SSH Access

Restrict SSH access to only the administrator’s public IP using an Azure Network Security Group rule:

- Protocol: TCP  
- Port: 22  
- Source: <YOUR_PUBLIC_IP>/32  
- Action: Allow  

![Securing the Application](<screenshots/Securing the Application.jpg>)
This prevents unauthorized SSH attempts from the internet.

---

### Step 7: Transfer Application Files (Staging)

From the local machine, navigate to the project directory containing the site files:

`cd "D:\RiseUp Migration\Project 1\site"`

Verify files exist:

index.html  
404.html  
css/  
images/  

Copy files to the VM staging directory: `scp -r . RiseUp-Portal:/tmp/site`

---

### Step 8: Deploy Application to Apache Directory

On the VM, verify files arrived: `ls -la /tmp/site`

Remove the default Apache placeholder file: `sudo rm -f /var/www/html/index.html`

![Finalizing File Transfer](<screenshots/Finalizing File Transfer.jpg>)

Copy application files into the live web directory: `sudo cp -r /tmp/site/* /var/www/html/`

![Test](<screenshots/Testing the Web Application.jpg>)

Fix ownership so Apache can read all files: `sudo chown -R www-data:www-data /var/www/html`

Restart Apache to apply changes: `sudo systemctl restart apache2`

![Permission Fixed](<screenshots/Permission Fixed.jpg>)

---

## Finished

After migration, the RiseUp Portal operates from a centralized, cloud-hosted environment with:

- Improved stability  
- Reduced operational overhead  
- Standardized access controls  
- Predictable deployment behavior  

This project establishes a reliable baseline for running server-based workloads in Azure and prepares the environment for future automation.

---

## Future Improvements

- Infrastructure provisioning with Terraform  
- Application deployment with Ansible  
- HTTPS using Let’s Encrypt  
- Azure Monitor and Log Analytics integration  
- Load balancing and scaling scenarios  


> 🚀 **Project Type**: Cloud Engineering / Infrastructure Migration   
> 🧰 **Tech Stack**: Azure VM, Linux, Apache, SSH, HTML/CSS  
> 🏦 **Use Case**: Financial Startup Website Migration  