require 'spec_helper'

describe User do
  it { should have_many(:item_ownerships) } 
  it { should have_many(:items) } 
end
