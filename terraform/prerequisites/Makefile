.PHONY: clean np pr apply-np apply-pr destroy-np destroy-pr
.DEFAULT_GOAL := clean

ENVIRONMENT = $(word 2,$@)
BACKEND_CONFIG = config/$(ENVIRONMENT).config
VAR_FILE = $(ENVIRONMENT).tfvars
PLAN_FILE = terraform-$(ENVIRONMENT).tfplan

clean:
	rm -rf .terraform

np: clean
	terraform init --backend-config=config/np.config
	terraform plan -var-file=np.tfvars -out=.terraform/terraform-np.tfplan

pr: clean
	terraform init --backend-config=config/pr.config
	terraform plan -var-file=pr.tfvars -out=.terraform/terraform-pr.tfplan

np-apply:
	terraform apply .terraform/terraform-np.tfplan

pr-apply:
	terraform apply .terraform/terraform-pr.tfplan

np-destroy:
	terraform destroy -var-file=np.tfvars 

pr-destroy:
	terraform destroy -var-file=pr.tfvars 	
