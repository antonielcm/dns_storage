FactoryBot.define do
  factory :domain_name do
    name { Faker::Internet.domain_name }
  end
end
