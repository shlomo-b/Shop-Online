# module "db" {
#     source  = "terraform-aws-modules/rds/aws"
#     version = "6.5.3"

#     identifier = "my-rds"

#     engine               = "postgres"
#     engine_version       = "14.10"
#     family               = "postgres14"
#     major_engine_version = "14"
#     instance_class       = "db.m5.large"

#     allocated_storage     = 20
#     max_allocated_storage = 0
#     storage_type          = "gp3"

#     manage_master_user_password = false
#     db_name                     = jsondecode(aws_secretsmanager_secret_version.database_credentials.secret_string)["DATABASE_NAME"]
#     username                    = jsondecode(aws_secretsmanager_secret_version.database_credentials.secret_string)["DATABASE_USER"]
#     password                    = jsondecode(aws_secretsmanager_secret_version.database_credentials.secret_string)["DATABASE_PASSWORD"]
#     port                        = 5432

#     multi_az               = false
#     vpc_security_group_ids = [module.sgs["vpc-one"].security_group_id]
#     create_db_subnet_group = true
#     db_subnet_group_name   = module.vpc["vpc-one"].database_subnet_group_name
#     subnet_ids             = [module.vpc["vpc-one"].public_subnets[0],
#      module.vpc["vpc-one"].public_subnets[1]]

#     publicly_accessible = true

#     maintenance_window = "mon:03:16-mon:03:46"
#     backup_window      = "21:26-21:56"

#     backup_retention_period   = 0
#     skip_final_snapshot       = false
#     deletion_protection       = false
#     storage_encrypted         = false
#     create_db_parameter_group = false

#     # performance_insights_enabled          = false
#     # performance_insights_retention_period = 7
#     # create_monitoring_role                = false
#     # monitoring_interval                   = 0
#     # monitoring_role_name                  = "${var.cluster_name}-rds-monitoring"
#     # monitoring_role_use_name_prefix       = true
#     # monitoring_role_description           = "Monitoring role for RDS ${var.cluster_name}-rds-terraform"

#     tags = {
#         Name = "my-rds"
#     }
# }
