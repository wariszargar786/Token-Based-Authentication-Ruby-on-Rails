module Response
  def json_response(message, isSuccessful, data, status)
    render json: {
      message: message,
      isSuccessful: isSuccessful,
      data: data
    }, status: status
  end
end