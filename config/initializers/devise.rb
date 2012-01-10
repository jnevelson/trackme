Devise.setup do |config|
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.use_salt_as_remember_token = true
  config.reset_password_within = 2.hours
end