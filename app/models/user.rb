class User < ApplicationRecord

  def gadget_quotes
    data['gadget_quotes'].map { |quote| GadgetPackage.new(quote) }
  end

  def gadget_quotes=(value)
    update(data: data.merge(gadget_quotes: value))
  end

  def selected_quote
    GadgetPackage.new(data['selected_quote'])
  end

  def selected_quote=(value)
    update(data: data.merge(selected_quote: value))
  end
end
