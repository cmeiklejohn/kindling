module ReceiptProcessor

  TOKEN = "[Kindle Edition]"

  # Find a {{Receipt}} by ID, take it's body, grep for Kindle editions, and
  # create {{Item}} and {{ItemOwnership}} records for the user if the
  # user exists.
  #
  # @param  [Receipt#id]
  # @return [true]
  #
  def self.perform(id)
    if receipt = Receipt.find_by_id(id)

      if user = User.find_by_email(receipt.email)

        receipt.lines.each do |line|
          if line.include?(TOKEN)
            if item = Item.find_or_create_by_title(strip_tags_and_tokens(line))
              receipt.for_item!(item.id) && user.acquire!(item)
            end
          end
        end

      else
        receipt.reject!
      end

      receipt.process!
    end
  end

  def self.strip_tags_and_tokens(line)
    line.gsub(/<\/?[^>]*>/, "").gsub(TOKEN, "").chomp.strip
  end

end
