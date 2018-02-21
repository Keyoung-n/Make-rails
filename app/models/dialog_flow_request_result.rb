class DialogFlowRequestResult
  include ActiveModel::Model

  attr_accessor :source,
                :resolvedQuery,
                :speech,
                :action,
                :actionIncomplete,
                :parameters,
                :contexts,
                :metadata,
                :fulfillment,
                :score

  def action=(value)
    @action = value.to_sym
  end

  def parameters=(value)
    @parameters = OpenStruct.new(value)
  end

  def contexts=(values)
    @contexts = values.map { |context| OpenStruct.new(context) }
  end
end
