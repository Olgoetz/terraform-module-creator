# Terraform Module Creator

Littel script to create the basic structure of a Terraform Module as described on https://www.terraform.io/docs/modules/structure.html.
Furthermore the pre-commit terraform hooks are set up if the requirements are met.

## Prerequisites for applying the hooks

- `pre-commit` https://pre-commit.com/
- `terraform` https://www.terraform.io/downloads.html
- `terraform-docs` https://github.com/terraform-docs/terraform-docs

## Usage

1. Clone or download the repository.

2. Symlink the `./create_tf_module.sh` so that is executable from everywhere:

```bash
# Create a symbolic link to `usr/local/bin/create_tf_module.sh` (you may change the path but it must be present within PATH environment variable):
$ ln -s -f ~/terraform-module-creator/create_tf_module.sh  /usr/local/bin/create_tf_module.sh
```

3. Execute this command for creating a folder `terraform-aws-kinesis-firehose` with a basic module structure:

```bash
# Creat module structure
$ ./create_tf_module.sh terraform-aws-kinesis-firehose
```
