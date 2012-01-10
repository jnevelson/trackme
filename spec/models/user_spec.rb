require 'spec_helper'

describe User do

  @attributes = { :first_name => "test", :last_name => "test", :email => "test@test.com" }

  it "should validate presence of fields" do
    expect { User.create! }.to raise_exception
  end

  it "should create a new user" do
    @user = User.create!(@attributes)

    @user[:first_name].should equal(@attributes[:first_name])
  end

end
