class Receipt < ActiveRecord::Base
  validates_presence_of :email, :body 

  belongs_to :item

  def self.receive(message)
    if receipt = self.find_or_create_by_email_and_body(message.from.first, message.body.decoded)
      ReceiptProcessor.perform(receipt.id)
    end
  end

  def lines
    body.split("\n")
  end

  def reject!
    update_attribute(:rejected, true)
  end

  def process!
    update_attribute(:processed, true)
  end

  def for_item!(item_id)
    update_attribute(:item_id, item_id)
  end

  def to_mail
    Mail.read_from_string(body)
  end
end
