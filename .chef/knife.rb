current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "mconigliaro"
client_key               "#{current_dir}/../certificates/chef-mconigliaro.pem"
validation_client_name   "conigliaro-validator"
validation_key           "#{current_dir}/../certificates/chef-conigliaro-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/conigliaro"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../chef/cookbooks"]
roles_path               ["#{current_dir}/../chef/roles"]
cookbook_copyright       "Michael Paul Thomas Conigliaro"
cookbook_license         "MIT"
cookbook_email           "mike [at] conigliaro [dot] org"