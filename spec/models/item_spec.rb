require 'spec_helper'

describe Item do
  it { should validate_presence_of(:title) } 

  context 'given a title' do 
    before { subject.title = 'Go to sleep!' }

    its(:title) { should == 'Go to sleep!' } 
  end
end
