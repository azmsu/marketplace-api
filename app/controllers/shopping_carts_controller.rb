class ShoppingCartsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :validate_request_body, only: :update

  def create
    @cart = ShoppingCart.create!

    render_response(@cart, :created)
  end

  def update
    @cart = ShoppingCart.completed.find(params[:id])

    add_item if params[:item_to_be_added].present?
    return if performed?

    @cart.checkout if params[:checkout]

    render_response(@cart)
  end

  private

  def validate_request_body
    if params[:item_to_be_added].nil? && params[:checkout].nil?
      render_response(
        { message: "Invalid update request body. Missing both keys 'item_to_be_added' and 'checkout'." },
        :bad_request
      )
    end
  end

  def item_params
    [
      Product.find(params[:item_to_be_added]["product_id"].to_i),
      params[:item_to_be_added]["count"].to_i
    ]
  end

  def add_item
    render_response(
      { message: "Product could not be added to cart." },
      :bad_request
    ) unless @cart.add_item(*item_params)
  end
end
