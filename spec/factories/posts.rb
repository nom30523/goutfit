FactoryBot.define do

  factory :post do
    appointed_day { Faker::Date.in_date_period }
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    outfit_id { FactoryBot.create(:outfit).id }
    user
  end

end