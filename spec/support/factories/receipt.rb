FactoryGirl.define do 
  factory :receipt do 
    email 'user@example.com'
    processed false
    body 'receipt body'
    item 
  end
end
