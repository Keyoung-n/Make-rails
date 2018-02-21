class RequestGadgetQuote

  def self.call(request)
    new(request).handle_request_gadget_quote
  end

  def initialize(request)
    @request = request
  end

  def handle_request_gadget_quote
    model = request.parameters[:device_model]

    quotes = gadget_quotes(model)

    {
      messages: [
        speech: gadget_quote_response(quotes),
        type: 0
      ]
    }
  end

  private
    attr_reader :request

    def gadget_quotes(model)
      client = Root::Insurance::Client.new(ENV['APP_ID'], ENV['APP_SECRET'], :sandbox)
      res = client.create_quote(
        type: :root_gadgets,
        model_name: model
      )

      res.map { |r| GadgetPackage.new(r) }
    end


    def gadget_quote_response(quotes)
      <<~RESPONSE
        Here’s what I have available for you:

        #{GadgetPackage.responses_from_collection(quotes)}

        Which option would you like to get? #{(1..quotes.count).to_a.to_s.tr('[','(').tr(']',')')}
      RESPONSE
    end
end
