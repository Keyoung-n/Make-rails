class QuoteController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        name = params['result']['parameters']['name']
        age = params['result']['parameters']['age']['amount']
        response = {
                        "messages" => [
                                    {
                                        "speech" => "Hey #{name} your premium amount is #{premium_amount(age)}",
                                        "type" => 0
                                    },
                                 ]
                    }

        render json: response
    end

    private

    def premium_amount age
        client = Root::Insurance::Client.new(ENV['APP_ID'], ENV['APP_SECRET'], :sandbox)
        ret = client.create_quote(
                type:                   :root_term,
                cover_amount:           1_000_000_00,
                cover_period:           "1_year",
                basic_income_per_month: 50_000_00,
                education_status:       :undergraduate_degree,
                smoker:                 false,
                gender:                 :female,
                age:                    age)
        ret[0]['module']['basic_income_per_month']
    end
end
