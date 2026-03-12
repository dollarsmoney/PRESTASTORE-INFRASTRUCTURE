# 🛒 PrestaShop AWS Free-Tier Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-623CE4?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Free%20Tier-FF9900?logo=amazon-aws&logoColor=white)
![PrestaShop](https://img.shields.io/badge/PrestaShop-8.x-DF0067?logo=prestashop&logoColor=white)

A minimal, cost-effective Terraform configuration to deploy **PrestaShop** on AWS Free Tier. Perfect for development, testing, or small production workloads.

---

## 📋 Architecture Overview
┌─────────────────┐         ┌─────────────────┐
│   Internet      │────────▶│   EC2 t2.micro  │
│   (HTTP/HTTPS)  │         │  (Amazon Linux 2) │
└─────────────────┘         │   PrestaShop    │
└────────┬────────┘
│
┌────────▼────────┐
│   RDS MySQL     │
│  db.t2.micro    │
│  (Private Subnet)│
└─────────────────┘
plain
Copy

| Component | Specification | Cost |
|-----------|--------------|------|
| **EC2** | `t2.micro` (Amazon Linux 2) | Free Tier ✅ |
| **RDS** | `db.t2.micro` MySQL 8.0, 20GB | Free Tier ✅ |
| **Storage** | 20GB GP2 | Free Tier ✅ |
| **Networking** | Default VPC + Security Groups | Free |

---

## 🚀 Quick Start

### Prerequisites

- [Terraform ≥ 1.5.0](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI configured](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) (`aws configure`)
- An existing EC2 Key Pair in your target AWS region

### 1. Clone & Configure

```bash
git clone <your-repo-url>
cd prestashop-aws-terraform
Create terraform.tfvars:
hcl
Copy
aws_region       = "us-east-1"
ssh_allowed_cidr = "YOUR_PUBLIC_IP/32"   # 🔒 Restrict SSH to your IP only
ec2_key_name     = "your-ec2-keypair-name"
db_username      = "prestashop"
db_password      = "CHANGE_ME_STRONG_PASSWORD"  # ⚠️ Use a strong password!
db_name          = "prestashop"
💡 Find your IP: curl ifconfig.me
2. Deploy
bash
Copy
terraform init
terraform plan
terraform apply
3. Access Your Outputs
After successful apply, Terraform returns:
bash
Copy
Outputs:
ec2_public_ip = "3.91.42.155"
rds_endpoint  = "prestashop-db.abc123xyz.us-east-1.rds.amazonaws.com:3306"
Table
Output	Description
ec2_public_ip	Access PrestaShop at http://<ip>
rds_endpoint	Database connection string
🔒 Security Groups
Table
Group	Port	Source	Purpose
PrestaShop-SG	80	0.0.0.0/0	HTTP traffic
PrestaShop-SG	443	0.0.0.0/0	HTTPS traffic
PrestaShop-SG	22	Your IP only	SSH access
PrestaShop-DB-SG	3306	EC2 SG only	MySQL (private)
📁 Project Structure
plain
Copy
.
├── main.tf          # Core AWS resources (VPC, EC2, RDS)
├── variables.tf     # Input variables
├── outputs.tf       # Deployment outputs
├── terraform.tfvars # Your configuration (gitignored)
└── README.md        # This file
🧹 Cleanup
To destroy all resources and avoid charges:
bash
Copy
terraform destroy
⚠️ Important Notes
Free Tier limits: 750 hrs/month EC2 + 750 hrs/month RDS for 12 months
SSH access: Always restrict to your IP (/32) — never use 0.0.0.0/0
Database: RDS is not publicly accessible; only the EC2 instance can connect
Backups: Enable RDS automated backups for production use
📝 License
MIT — Free to use and modify.
plain
Copy

---

**Key fixes made:**
- Proper code block fences with ` ``` ` on separate lines
- Tables use standard Markdown syntax with `|` delimiters
- ASCII art wrapped in code blocks so it preserves formatting
- Horizontal rules (`---`) to separate sections cleanly
- No inline HTML that might break rendering

This will render properly with proper spacing, aligned tables, and readable code blocks on GitHub.