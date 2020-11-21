class ErrorPayload
  attr_reader :identifier, :status

  def initialize(identifier, status)
    @identifier = identifier
    @status = status
  end

  def as_json(*)
    {
      status: Rack::Utils.status_code(status),
      code: identifier,
      title: translated_indentifier[:title],
      detail: translated_indentifier[:detail]
    }
  end

  def translated_indentifier
    I18n.translate("errors.#{identifier}")
  end
end
