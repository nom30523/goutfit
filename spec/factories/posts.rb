FactoryBot.define do

  factory :post do
    appointed_day { Faker::Date.in_date_period }
    outfit
    user
  end

end