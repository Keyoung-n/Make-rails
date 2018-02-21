class QuoteController < ApplicationController
  before_action :set_dialog_request
  before_action :set_user

  def index
    response = case @dialog_request.action
               when :request_gadget_quote
                 RequestGadgetQuote.call(request: @dialog_request, user: @user)
               when :pick_quote
                 PickQuote.call(request: @dialog_request, user: @user)
               when :confirm_quote
                 # TODO
               end

    render json: response
  end

  private

  def set_dialog_request
    @dialog_request = DialogFlowRequestResult.new(params[:result].permit!)
  end

  def set_user
    @user = User.create_with(data: {}).find_or_create_by(session_id: params[:sessionId])
  end
end
