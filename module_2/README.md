# Terraform Sample Workshop Module 2

This module is responsible to teach you how to create modules in terraform and use them, you will learn how to create re-usable Terraform resources to improve agility when coding infraestructure.

A module is a container for multiple resources that are used together. Modules can be used to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

**Re-usable modules are defined using all of the same configuration language concepts we use in root modules**

If you need any further information, check the offical [Terraform Documentation](https://www.terraform.io/docs/modules/index.html)

# Folder Structure

```
 ── modularized_tf
    ├── environments
    │   └── providers
    │       └── aws
    │           └── prd
    │               ├── applications/
    │               ├── environment.tf
    │               └── infraestructure
    │                   └── vpc/
    └── modules
        └── providers
            └── aws
                ├── asg
                ├── elb
                ├── launch_config
                ├── security_group
                │   ├── attach_sg_ec2
                │   ├── create_sg
                │   └── create_sg_rule
                └── vpc
```

[environments](modularized_tf/environments) - This folder has the code that is responsible to call the modules, the modules together make a stack.

[modules](modularized_tf/modules) - This is the folder where the modules are stored, so inside this folder we have the Terraform Resources

Inside every module and provider environment folder, we have the same structure of files descibred in module 1:

- output.tf
- main.tf
- vars.tf
- data.tf

If you need any information, go back to [module 1](../module_1/) and check it

# Deploying our stack in a modularized way

Now we don't have anymore one snippet that create all the AWS resources, we have a snippet that combine many modules to create AWS resources.

We also splitted the stack in two, it means, two different state files.

- The **infraestructure/** folder is where the infraestructure components will be created, components that maybe will be used for many stacks or applications, like VPC, Route 53 etc.

- The **applications/** folder is where our application stack will be created.


<p align="center"> 
<img src="images/terraform_module.png">
</p>

## Deploying the VPC

Let's deploy first our VPC, since we need the networking components in order to create our nginx stack.

Execute:

```shell
cd modularized_tf/environments/providers/aws/prd/infraestructure/vpc
```

Now we need to change the **AWS Bucket** where out Terraform State will be saved.

Open **modularized_tf/environments/providers/aws/prd/infraestructure/vpc/main.tf** and do the follow:

```terraform
terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "<YOUR BUCKET NAME GOES HERE>"
    key     = "environments/providers/aws/prd/infraestructure/vpc/main.tf"
    encrypt = true
  }
}
```

We are able now to init our Terraform inside our folder, for this run the follow command:

```
terraform init
```