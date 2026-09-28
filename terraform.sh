#Step 1 — Check Ubuntu

#In your VS Code terminal:

cat /etc/os-release

#You should see Ubuntu information.

#Step 2 — Install prerequisites
sudo apt update
sudo apt install -y gnupg wget
#Step 3 — Add HashiCorp's GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
#Step 4 — Add the HashiCorp repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

#This is the current repository configuration recommended by HashiCorp.

#Step 5 — Update package list
sudo apt update
#Step 6 — Install Terraform
sudo apt install -y terraform
#Step 7 — Verify
terraform version



