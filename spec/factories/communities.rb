# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :community, :class => 'Community' do
    name "MyString"
    address "MyString"
    description "MyText"
  end
end
