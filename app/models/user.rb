class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :first_name, :last_name, :email

  has_many :locations

  before_save :generate_api_key!

  private

  def generate_api_key!
    key = [Time.now, (1..10).map { rand.to_s }].join("--")
    self.api_key = Digest::SHA1.hexdigest(key)
  end

end
