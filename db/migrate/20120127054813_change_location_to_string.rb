class ChangeLocationToString < ActiveRecord::Migration
  def up
    change_column :locations, :latitude, :string
    change_column :locations, :longitude, :string 
  end

  def down
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float 
  end
end
