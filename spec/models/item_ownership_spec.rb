require 'spec_helper'

describe ItemOwnership do
  it { should validate_presence_of(:user_id) } 
  it { should validate_presence_of(:item_id) } 
  it { should belong_to(:item) } 
end
