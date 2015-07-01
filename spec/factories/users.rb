FactoryGirl.define do
  sequence :email do |n|
    "fakeemail#{n}@example.com"
  end

  factory :user do
    email
    password "12345678"
  end
end
