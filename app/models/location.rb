class Location < ActiveRecord::Base

  validates_presence_of :latitude, :longitude

  belongs_to :user

end
