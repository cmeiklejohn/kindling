class ReceiptProcessor

  TOKEN = "[Kindle Edition]"

  attr_accessor :receipt

  def initialize(receipt) 
    @receipt = receipt
  end

  # Given a {{Receipt}}, take it's body, grep for Kindle editions, and
  # create {{Item}} and {{ItemOwnership}} records for the user if the
  # user exists.
  #
  # @param  [Receipt]
  # @return [Boolean]
  #
  def perform
    if user = User.find_by_email(receipt.email)

      receipt.lines.map do |line|
        if contains_product?(line)
          if item = Item.for_product(extract_attributes(line))
            receipt.for_item!(item.id) && user.acquire!(item)
          end
        end
      end

    else
      receipt.reject!
    end

    receipt.process!
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

end
