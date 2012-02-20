FactoryGirl.define do 
  factory :item do 
    sequence(:title) { |counter| "The Book, Version #{counter}" }
  end
end
