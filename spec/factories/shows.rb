FactoryGirl.define do
  factory :show do
    sequence(:name) { |n| "Show#{n}" }
  end

end

# name "MyString"
# premiere "MyString"
# day "MyString"
# time "MyString"
# station "MyString"
# reminder "2015-03-30 13:42:23"
# pic_url "MyString"
