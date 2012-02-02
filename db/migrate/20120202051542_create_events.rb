class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.integer :owner_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamp
    end
  end
end
