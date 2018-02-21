class GadgetPackage
  include ActiveModel::Model

  attr_accessor :quote_package_id,
                :package_name,
                :sum_assured,
                :base_premium,
                :suggested_premium,
                :module,
                :created_at

  def self.responses_from_collection(collection)
    collection.map
      .with_index(1) { |quote, index| quote.to_dialog_response(index) }
      .join("\n\n")
  end

  def sum_assured_text
    "R #{sum_assured / 100.0}"
  end

  def suggested_premium_text
    "R #{suggested_premium / 100.0}"
  end

  def to_dialog_response(index)
    <<~RESPONSE
      Option #{index}: 
      You can get #{package_name} covering a value of  #{sum_assured_text}.
      This would cost #{suggested_premium_text} per month
    RESPONSE
  end
end
