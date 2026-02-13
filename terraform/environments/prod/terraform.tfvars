# Production environment configuration

environment              = "prod"
namespace                = "online-boutique-prod"
enable_monitoring        = true
replica_count            = 2
resource_limits_enabled  = true
cpu_limit                = "500m"
memory_limit             = "512Mi"
cpu_request              = "200m"
memory_request           = "256Mi"
