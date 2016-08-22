FactoryGirl.define do
  factory :account do
    email 'test@test.com'
    password '123456'
    password_confirmation '123456'
  end
end
