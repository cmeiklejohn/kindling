require 'spec_helper'

describe ReceiptProcessor do 
  context 'given a receipt for a user' do 
    let(:receipt) { stub_model(Receipt, :body => body, :email => 'test@test.com') }
    let(:body)    { File.read(File.join(Rails.root, 'spec/support/receipts/valid_amazon_receipt.txt')) }

    subject { ReceiptProcessor.new(receipt) } 

    it 'properly extracts the url and title given the line item' do 
      attributes = subject.send(:extract_attributes, receipt.lines[250])
      attributes[:title].should       == 'The Dip: A Little Book That Teaches You When to Quit (and When to Stick)'
      attributes[:product_url].should == 'http://www.amazon.com/gp/product/B000QCSA54'
    end
  end
end
