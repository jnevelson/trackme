require 'spec_helper'

describe Friendship do

  it "should create friends" do
    user = Factory(:user1)
    friend = Factory(:friend)

    user.add_friend(friend)
    user.friends.first.should == friend
  end
  
  it "should friend people unidirectionally" do
    user1 = Factory(:user1)
    user2 = Factory(:user2)
    user1.add_friend(user2)

    user1.friends.should == [user2]
    user2.friends.should == [user1]
  end

end
