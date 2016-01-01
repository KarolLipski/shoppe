# initializer for custom config file
# use this like : APP_CONFIG['property_name']
APP_CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]