FactoryGirl.define do
  factory :todo do
    text "MyText"
    completed false
    account_id 1
  end
end
