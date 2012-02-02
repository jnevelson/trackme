FactoryGirl.define do

  factory :user do
    first_name 'first'
    last_name 'last'
    email 'email@email.com'
    password 'blah'
  end

  factory :user1, :class => "User" do
    first_name 'user1'
    last_name 'user1last'
    email 'user1@email.com'
    password 'user1'
  end

  factory :friend, :class => "User" do
    first_name 'my'
    last_name 'friend'
    email 'friend@email.com'
    password 'friend'
  end

end