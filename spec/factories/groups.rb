FactoryGirl.define do
  factory :group do
    name "My Test Group"
    location "101 South Lane, Brooklyn NY"
    description "This is a test group it's only a test group do not adjust your expectations of this application"
    photo_url "https://wwww.google.com/"
    creator User.first
  end

end
