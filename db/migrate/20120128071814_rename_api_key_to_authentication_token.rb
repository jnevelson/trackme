class RenameApiKeyToAuthenticationToken < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :api_key, :authentication_token
    end
  end

  def down
    change_table :users do |t|
      t.rename :authentication_token, :api_key
    end
  end
end
