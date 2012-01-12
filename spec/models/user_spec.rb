require 'spec_helper'

describe User do

  attributes = { :first_name => "test", :last_name => "test", :email => "test@test.com", :password => "test" }

  it "should validate presence of fields" do
    expect { User.create! }.to raise_exception
  end

  it "should create a new user" do
    @user = User.create!(attributes)
    @user[:first_name].should equal(attributes[:first_name])
  end

  it "should generate an api key when the user is created" do
    @user = User.create!(attributes)
    @user.api_key.should_not equal(nil)
  end

end
