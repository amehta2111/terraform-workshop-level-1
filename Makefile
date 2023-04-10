UNAME:= $(shell uname)
ifeq ($(UNAME),Darwin)
		OS_X  := true
		SHELL := /bin/bash
else
		OS_DEB  := true
		SHELL := /bin/bash
endif

TERRAFORM:= $(shell command -v terraform 2> /dev/null)
TERRAFORM_VERSION:= "1.4.4"

ifeq ($(OS_X),true)
		TERRAFORM_MD5:= $(shell md5 -q `which terraform`)
		TERRAFORM_REQUIRED_MD5:= 5ffef5cda79c19fe01e0fbd6470085ed
else
		TERRAFORM_MD5:= $(shell md5sum - < `which terraform` | tr -d ' -')
		TERRAFORM_REQUIRED_MD5:= 8e463d4a8abd62b8bc1a6ad9cfd7cc54
endif

all: check tflint tfsec init plan apply

check:
	@echo "Checking Terraform version... success expecting md5 of [${TERRAFORM_REQUIRED_MD5}], found [${TERRAFORM_MD5}]"
	@if [ "${TERRAFORM_MD5}" != "${TERRAFORM_REQUIRED_MD5}" ]; then echo "Please ensure you are running terraform ${TERRAFORM_VERSION}."; exit 1; fi
	@sops --decrypt terraform-workshop-vm.sops.yaml | sed "s/key: //g" > terraform-workshop-vm.pub
	@sops --decrypt terraform-workshop-vm-private.sops.yaml | sed "s/data: |//g" > terraform-workshop-vm-private


default:
	@echo "Creates a Terraform system from a template."
	@echo "The following commands are available:"
	@echo " - init               : runs terraform init for an environment"
	@echo " - plan               : runs terraform plan for an environment"
	@echo " - apply              : runs terraform apply for an environment"
	@echo " - destroy            : will delete the entire project's infrastructure"

tflint:
	@echo "Running terraform lint scan..."
	@tflint --config /Users/amanmehta/Downloads/level-1-code/tflint.hcl

tfsec:
	@echo "Running terraform security scan..."
	@tfsec --minimum-severity CRITICAL  --minimum-severity HIGH

init: check
	@terraform fmt
	@echo "Pulling the required modules..."
	#@terraform init -backend-config=backend.tfvars
	@terraform init
	@terraform validate

plan: check
	@terraform plan


apply: check
	@terraform apply
	

destroy: check
	@echo "## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##"
	@echo "Are you really sure you want to completely destroy environment ?"
	@echo "## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##"
	@read -p "Press enter to continue"
	@terraform destroy