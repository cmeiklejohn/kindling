require 'spec_helper'

shared_examples_for "a processable receipt" do
  context 'with an instance of the processor' do 
    let(:item) { stub_model(Item) }
    let(:attributes) do 
      {
        :title       => 'The Dip: A Little Book That Teaches You When to Quit (and When to Stick)',
        :product_url => 'http://www.amazon.com/gp/product/B000QCSA54'
      }
    end

    before do 
      receipt.stub(:body).and_return(body)
    end

    subject { ReceiptProcessor.new(receipt) } 

    it 'properly extracts the url and title given the line item' do 
      Item.should_receive(:for_product).with(attributes).and_return(item)
      attributes = subject.perform
    end
  end
end

describe ReceiptProcessor do 
  context 'given a receipt' do 
    let(:receipt) { stub_model(Receipt, :id => 1, :body => "") }

    context 'with a saved receipt' do 
      before do 
        Receipt.stub(:find_by_id).and_return(receipt)
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

        context 'given a receipt' do
          let(:body) { File.read(File.join(Rails.root, 'spec/support/receipts/valid_amazon_receipt.html')) }

          it_behaves_like "a processable receipt"
        end

        context 'given a multipart forwarded receipt' do
          let(:body) { File.read(File.join(Rails.root, 'spec/support/receipts/valid_forwarded_multipart_amazon_receipt.html')) }

          it_behaves_like "a processable receipt"
        end
      end

      context 'without a valid user' do 
        it 'can process a receipt and mark rejected' do 
          receipt.should_receive(:reject!).and_return(true)
          subject.perform(receipt.id).should be_true
        end
      end
    end
  end
end
