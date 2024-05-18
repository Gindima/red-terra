module "php_app" {
  source    = "../../modules/php-app"
  namespace = "dev"
}

module "mysql" {
  source              = "../../modules/mysql"
  namespace           = "dev"
  mysql_root_password = "root"
}