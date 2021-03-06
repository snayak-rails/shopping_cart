# frozen_string_literal:true

# methods to check for stock avaibility of products
module Available
  extend ActiveSupport::Concern

  def stock_available?
    product = Product.find_by_id(params[:product_id])
    return if product.stock >= 1
    flash[:error] = 'Item out of stock'
    redirect_to product_path(product.id)
  end

  def cart_items_in_stock?
    @cart.cart_items.all.each do |cart_item|
      product = Product.find_by_id(cart_item.product_id)
      next if cart_item.quantity <= product.stock
      show_error(product)
    end
  end

  def show_error(product)
    message = 'Product: ' + product.title +
              ' has ' + product.stock.to_s + ' pieces available '
    flash[:error] = message + '<br>'
    redirect_to cart_checkout_index_path
  end
end
