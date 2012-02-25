require 'spec_helper'

describe ReceiptProcessor do 
  context 'given a receipt' do 
    let(:receipt) { stub_model(Receipt, :id => 1, :body => body) }
    let(:body)    { File.read(File.join(Rails.root, 'spec/support/receipts/valid_amazon_receipt.html')) }

    before do 
      Receipt.stub(:find_by_id).and_return(receipt)
    end

    context 'with an instance of the processor' do 
      subject { ReceiptProcessor.new(receipt) } 

      it 'properly extracts the url and title given the line item' do 
        attributes = subject.send(:extract_attributes, receipt.lines[249])
        attributes[:title].should       == 'The Dip: A Little Book That Teaches You When to Quit (and When to Stick)'
        attributes[:product_url].should == 'http://www.amazon.com/gp/product/B000QCSA54'
      end
    end

    subject { ReceiptProcessor } 

    context 'with a valid user' do 
      let(:user) { stub_model(User) } 

      before do 
        User.stub(:find_by_email).and_return(user)
      end

      it 'can process a receipt and mark as processed' do 
        receipt.should_receive(:process!).and_return(true)
        subject.perform(receipt.id).should be_true
      end
    end

    context 'without a valid user' do 
      it 'can process a receipt and mark rejected' do 
        receipt.should_receive(:process!).and_return(false)
        subject.perform(receipt.id).should be_true
      end
    end
  end
end
