FactoryBot.define do

  factory :outfit do
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_img.jpg'))}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end

end