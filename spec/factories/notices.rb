# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notice do
    tag_type "MyString"
    title "MyString"
    content "MyText"
  end
end
