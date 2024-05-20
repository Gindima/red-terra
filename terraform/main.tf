module "php_app" {
  source = "./modules/php-app"
}

module "mysql" {
  source = "./modules/mysql"
  mysql_root_password = "root"
}
