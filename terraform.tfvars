environment = {
  default = {
    # Global variables
    cluster_name                   = "codedevops-cluster"
    region                         = "ap-south-1"
    env                            = "test"
    vpc_id                         = "vpc-0580386c4ee062d6f"
    vpc_cidr                       = "10.0.0.0/16"
    public_subnet_ids              = ["subnet-04fa0c8ce111618cf", "subnet-048ed4bbfedf6706b"]
    cluster_version                = "1.29"
    cluster_endpoint_public_access = true


    # EKS variables
    eks_managed_node_groups = {
      # generalworkload-v4 = {
      #   min_size       = 1
      #   max_size       = 1
      #   desired_size   = 1
      #   instance_types = ["m5a.xlarge"]
      #   capacity_type  = "ON_DEMAND"
      #   disk_size      = 60
      #   ebs_optimized  = true
      # }
    }
    cluster_security_group_additional_rules = {}

    # EKS Cluster Logging
    cluster_enabled_log_types = ["audit"]
    eks_access_entries = {
      viewer = {
        user_arn = []
      }
      admin = {
        user_arn = ["arn:aws:iam::434605749312:root"]
      }
    }
    # EKS Addons variables 
    coredns_config = {
      replicaCount = 1
    }
  }
  aws_ebs_csi_driver_config = {
    controller = {}
  }
}
