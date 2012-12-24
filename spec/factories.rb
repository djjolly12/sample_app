require "rspec"

FactoryGirl.define do
  factory :user do
    name "Dan"
    email "dan_jolly@comcast.net"
    password "testing"
    password_confirmation "testing"
  end

  factory :new_user do
    name "New Name"
    email "new@example.com"
    password "testing"
    password_confirmation "testing"
  end
end