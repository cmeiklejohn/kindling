FactoryGirl.define do 
  factory :receipt do 
    email 'christopher.meiklejohn@gmail.com'
    processed false
    body 'receipt body'
    item 
  end
end
