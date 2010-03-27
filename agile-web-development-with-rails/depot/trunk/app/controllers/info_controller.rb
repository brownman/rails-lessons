class InfoController < ApplicationController
  def who_bought
    @product = Product.find(params[:id])
    @orders = @product.orders
    respond_to do |accepts|
      accepts.html
      accepts.xml
    end
  end
end
