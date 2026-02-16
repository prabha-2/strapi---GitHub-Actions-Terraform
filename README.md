# Strapi Deployment with GitHub Actions & Terraform

This project demonstrates a **fully automated deployment** of a Strapi CMS application using **Docker**, **GitHub Actions CI/CD**, and **Terraform** to provision an EC2 instance on AWS.

---

## 🔹 Project Overview

- **Goal:** Automate the deployment of Strapi on a cloud server.
- **Technologies Used:**
  - Strapi (Node.js CMS)
  - Docker (containerization)
  - GitHub Actions (CI/CD)
  - Terraform (infrastructure as code)
  - AWS EC2 (cloud hosting)
- **CI/CD Pipeline:**
  1. Build Docker image on code push.
  2. Push image to Docker Hub.
  3. Terraform workflow manually triggered to deploy image on EC2.

---


---

## 🔹 Setup Instructions

### 1. GitHub Secrets
Add the following secrets in **Settings → Secrets → Actions**:

| Secret Name            | Description                                  |
|------------------------|----------------------------------------------|
| DOCKER_USERNAME         | Your Docker Hub username                     |
| DOCKER_PASSWORD         | Docker Hub password                          |
| AWS_ACCESS_KEY_ID       | AWS IAM user access key                       |
| AWS_SECRET_ACCESS_KEY   | AWS IAM user secret key                        |
| AWS_KEY_NAME            | Name of your EC2 key pair                     |

---

### 2. CI/CD Workflow
- Triggered automatically on push to `main` branch.
- Builds Docker image for Strapi and pushes to Docker Hub.

### 3. Terraform Deployment
- Triggered manually via **GitHub Actions → Deploy with Terraform → Run workflow**.
- Provisions a **t2.micro EC2** instance in AWS Mumbai (`ap-south-1`).
- Installs Docker, pulls Strapi Docker image, and runs container on port 1337.
- Outputs **public IP** of EC2 instance.

---

### 4. Accessing the Application
After Terraform deploy:

1. Copy the public IP from workflow outputs:

Outputs:
public_ip = xx.xx.xx.xx


2. Open in browser:


http://xx.xx.xx.xx:1337


You should see the **Strapi application running live**.

---

## 🔹 Terraform Files Overview

- `provider.tf` – AWS provider configuration.  
- `variables.tf` – Variables for Docker username, image tag, and key name.  
- `main.tf` – Creates security group and EC2 instance; runs Docker container.  
- `outputs.tf` – Outputs public IP of the EC2 instance.

---

## 🔹 Skills Highlighted

- Infrastructure as Code (Terraform)  
- CI/CD pipeline setup (GitHub Actions)  
- Docker containerization and image management  
- AWS EC2 provisioning and security groups  
- Beginner-friendly automation and workflow design  

---

## 🔹 Notes

- Folder and file names are **case-sensitive** (important for GitHub Actions).  
- Docker image tag is automatically generated from the commit SHA.  
- EC2 instance type: `t2.micro` (free tier compatible).  
- Strapi port: `1337`.

---









