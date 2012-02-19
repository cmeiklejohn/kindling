require 'spec_helper'

describe Receipt do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:body) }
  it { should belong_to(:item) } 
end
