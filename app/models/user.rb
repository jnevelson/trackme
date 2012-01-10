class User < ActiveRecord::Base

  has_secure_password

  validates_presence_of :first_name, :last_name, :email, :password
  validates_uniqueness_of :email

  has_many :locations

end
