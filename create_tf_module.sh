#!/bin/bash

set -e

# *********************************************
# FUNCTIONS
# *********************************************

usage() {
    echo "------------------------------------------------------------------------------------------"
    echo "Usage: $0 terraform-provider-modulename"
    echo "  E.g: $0 terraform-aws-lambda-function"
    echo "------------------------------------------------------------------------------------------"
    exit 1
}

# *********************************************
# TESTING INPUT
# *********************************************
if [ -z $1 ]; then
    echo "[ERROR]: No argument passed."
    usage
fi

if ! [[ $1 =~ terraform-(aws|azure)-\w* ]]; then
    echo "[ERROR]: Wrong format of the folder."
    usage

fi 


# *********************************************
# CREATING FILES AND DIRECTORIES
# *********************************************

module_name=$1
mkdir $module_name

cd $module_name

echo "Creating .tf files..."

touch main.tf outputs.tf variables.tf versions.tf

csp=$(echo $module_name | cut -d- -f2)
module=$(echo $module_name | cut -d- -f3- | sed s/-/' '/g)


echo "Creating README.md..."

cat <<EOF > README.md
# $(echo $csp | tr '[a-z]' '[A-Z]') $(echo $module | tr '[a-z]' '[A-Z]') Terraform Module

A Terraform module to provision ...

## Features

## Examples

## Usage

EOF

mkdir examples

echo "Creating .gitignore..."

cat <<EOF > .gitignore
*.tfstate
*.tfstate.*
*.hcl
.terraform/
*.terraform/
myplan

EOF


# *********************************************
# SETTING UP PRECOMMIT
# *********************************************

if test $(command -v pre-commit) && test $(command -v terraform) && test $(command -v terraform-docs); then
    echo "Creating pre-commit config file..."

    cat <<EOF > .pre-commit-config.yaml
repos:
    - repo: git://github.com/antonbabenko/pre-commit-terraform
      rev: v1.45.0 # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
      hooks:
            - id: terraform_validate
            - id: terraform_fmt
            - id: terraform_docs

EOF

    echo -e "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->\n" >> README.md
    echo "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->" >> README.md

    echo "Install pre-commit hooks..."
    
    pre-commit install

fi

echo "Finished!"
