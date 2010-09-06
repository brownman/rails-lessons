class AddPriceToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal
    
    # migrate product prices into line items
    LineItem.all.each do |lineitem|
      unless lineitem.product.nil?
        lineitem.price = lineitem.product.price
        lineitem.save
      end
    end
  end

  def self.down
    remove_column :line_items, :price
  end
end
