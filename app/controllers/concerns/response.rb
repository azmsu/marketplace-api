module Response
  def render_response(json, status = :ok)
    render json: json, status: status
  end
end
