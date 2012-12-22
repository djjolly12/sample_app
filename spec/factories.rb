require "rspec"

FactoryGirl.define do
  factory :user do
    name "Dan"
    email "dan_jolly@comcast.net"
    password "testing"
    password_confirmation "testing"
  end
end