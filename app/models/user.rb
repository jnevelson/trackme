class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :first_name, :last_name, :email

  has_many :locations
  has_many :friends, :through => :friendships, :class_name => "User"
  has_many :friendships, :foreign_key => "user_id"

  before_save :generate_api_key!

  def post_location(params = {})
    Location.create!(:user => self, :longitude => params[:longitude], :latitude => params[:latitude])
  end

  def add_friend(user)
    Friendship.create! :user => self, :friend => user
  end

  private

  def generate_api_key!
    key = [Time.now, (1..10).map { rand.to_s }].join("--")
    self.api_key = Digest::SHA1.hexdigest(key)
  end

end
