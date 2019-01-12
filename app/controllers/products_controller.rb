class ProductsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :validate_request_body, only: :update

  def index
    available = params[:available].present? && params[:available] == 'true'
    @products = Product.filter(available)

    render_response(@products)
  end

  def show
    @product = Product.find(params[:id])

    render_response(@product)
  end

  def update
    @product = Product.available.find(params[:id])
    @product.purchase if params[:purchase]

    render_response(@product)
  end

  private

  def validate_request_body
    if params[:purchase].nil?
      render_response({ message: "Invalid update request body. Missing key 'purchase'." }, :bad_request)
    end
  end
end
