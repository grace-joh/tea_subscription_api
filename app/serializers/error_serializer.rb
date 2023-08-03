class ErrorSerializer
  include JSONAPI::Serializer

  def self.serialize(errors, status)
    {
      errors: [
        {
          status: status.to_s,
          title: "Record invalid",
          detail: errors.message
        }
      ]
    }
  end
end
