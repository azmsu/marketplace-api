module Response
  def render_response(json, status = :ok, args = {})
    render json: json, status: status, except: [:created_at, :updated_at], **args
  end
end
