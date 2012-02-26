class ReceiptProcessor

  TOKEN = "[Kindle Edition]"

  attr_accessor :receipt

  def initialize(receipt) 
    @receipt = receipt
  end

  # Process a given receipt.
  #
  # @return [Boolean]
  #
  def perform
    if user = User.for_receipt(receipt)
      receipt.process! && perform_for_user(user)
    else
      receipt.reject!
    end

    true
  end

  # Find a receipt by id, create an instance of the processor and run
  # the processing code.
  #
  # @param  [Receipt#id]
  # @return [Boolean]
  #
  def self.perform(id)
    Receipt.find_by_id(id).tap do |receipt|
      self.new(receipt).perform if receipt
    end
  end

  private 

  # For a particular {{User}}, create an {{Item}} and an
  # {{ItemOwnership}} for each item that they've purchased. 
  #
  # @param  [User]
  # @return [Array<Boolean>]
  # @private 
  #
  def perform_for_user(user)
    receipt.to_mail.tap do |mail|

      mail_to_parts(mail).map do |part|
        part.split("\n").map do |line|

          if contains_product?(line)
            if item = Item.for_product(extract_attributes(line))
              receipt.for_item!(item.id) && user.acquire!(item)
            end
          end

        end
      end

    end
  end 

  # Given a line containing a product, extract attributes needed to
  # create an item in our database.
  #
  # @param  [String]
  # @return [Hash]
  # @todo   Very naive, but functional.
  # @private
  #
  def extract_attributes(line)
    title = clean(detokenize(strip_tags(line), TOKEN))

    if line =~ /<a href="(.*)">/
      product_url = $1;
    end

    { :title => title, :product_url => product_url }
  end

  # Determine if a line contains a product.
  #
  # @param  [String]
  # @return [Boolean]
  # @private
  #
  def contains_product?(line) 
    line.include?(TOKEN)
  end

  # Strip tags off of a string.
  #
  # @param  [String]
  # @return [String]
  # @private 
  #
  def strip_tags(line)
    line.gsub(/<\/?[^>]*>/, "")
  end

  # Detokenize a string.
  #
  # @param  [String]
  # @param  [String]
  # @return [String]
  # @private 
  #
  def detokenize(line, token)
    line.gsub(token, "")
  end

  # Clean a line from whitespace.
  #
  # @param  [String]
  # @return [String]
  # @private 
  #
  def clean(line)
    line.chomp.strip
  end

  # Take a mail object and map to it's body, or the body of all of it's
  # parts.
  #
  # @param  [Mail]
  # @return [Array<String>]
  # @private 
  #
  def mail_to_parts(mail)
    mail.parts.empty? ? [mail.to_s] : mail.parts.map { |part| part.to_s } 
  end

end
