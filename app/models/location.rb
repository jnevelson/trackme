class Location < ActiveRecord::Base

  validates_presence_of :latitude, :longitude, :user

  belongs_to :user, :autosave => true

end
