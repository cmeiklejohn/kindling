Given /^a registered user$/ do
  @user = Factory.create(:user)
end

Given /^a valid receipt from Amazon for an ebook for that user$/ do
  file     = File.read(File.join(Rails.root, 'spec/support/receipts/valid_amazon_receipt.txt'))
  @receipt = Factory.create(:receipt, :email => @user.email, :body => file)
end

When /^the receipt processor runs$/ do
  ReceiptProcessor.perform(@receipt.id)

  @receipt.reload
  @user.reload if @user
end

Then /^an record should be created for that item$/ do
  @item = Item.find_by_title_and_product_url('The Dip: A Little Book That Teaches You When to Quit (and When to Stick)', 'http://www.amazon.com/gp/product/B000QCSA54')

  @item.should_not be_nil
  @receipt.item.should == @item
end

Then /^an ownership of that item should be recorded for that user$/ do
  @user.items.should include(@item)
end

Then /^the receipt should be marked as processed$/ do
  @receipt.processed.should == true
end

Then /^the receipt should not be marked as rejected$/ do
  @receipt.rejected.should_not == true
end

Given /^a valid receipt from Amazon for an ebook for another user$/ do
  file     = File.read(File.join(Rails.root, 'spec/support/receipts/valid_amazon_receipt.txt'))
  @receipt = Factory.create(:receipt, :email => 'no-email@gmail.com', :body => file)
end

Then /^the receipt should be marked as rejected$/ do
  @receipt.rejected.should == true
end
