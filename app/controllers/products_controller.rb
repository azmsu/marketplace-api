class ProductsController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    available = params[:available].present? && params[:available] == 'true'
    @products = Product.filter(available)

    render_response(@products)
  end

  def show
    @product = Product.find(params[:id])

    render_response(@product)
  end
end
