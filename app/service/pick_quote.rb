class PickQuote
  def self.call(request:, user:)
    new(request: request, user: user).handle
  end

  def initialize(request:, user:)
    @request = request
    @user = user
  end

  def handle
    selected_option = request.parameters.number.to_i - 1

    user.update(selected_quote: user.gadget_quotes[selected_option])
    @selected_quote = user.selected_quote

    {
      messages: [
        speech: message_speech,
        type: 0
      ]
    }
  end

  private
    attr_reader :request, :user

    def message_speech
      <<~TEXT
      Here are all the details of the package you selected:

      Name: #{@selected_quote.package_name}
      Cover Value: #{@selected_quote.sum_assured_text}
      Monthly Premium: #{@selected_quote.suggested_premium_text}
      Details: “Phone insurance for - #{@selected_quote.module['model']} (#{@selected_quote.module['model']})

      Do you accept this quote?
      TEXT
    end
end
