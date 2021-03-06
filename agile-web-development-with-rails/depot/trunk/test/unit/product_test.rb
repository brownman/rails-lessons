require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < Test::Unit::TestCase
  fixtures :products

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    product = Product.new
    assert !product.valid?
    assert product.errors.invalid?(:title)
    assert product.errors.invalid?(:description)
    assert product.errors.invalid?(:price)
    assert product.errors.invalid?(:image_url)
  end
  
  def test_positive_price
    product = Product.new(:title        =>  "My Book Title",
                          :description  =>  "yyy",
                          :image_url    =>  "zzz.jpg")
    product.price = -1
    assert !product.valid?
    assert_equal "should be at least 0.01", product.errors.on(:price)
    
    product.price = 0
    assert !product.valid?
    assert_equal "should be at least 0.01", product.errors.on(:price)
    
    product.price = 1
    assert product.valid?
  end
  
  def test_unique_title
    product = Product.new(:title        =>  products(:ruby_book).title,
                          :description  =>  "yyy",
                          :price        =>  1,
                          :image_url    =>  "fred.gif")
    assert !product.save
    assert_equal ActiveRecord::Errors.default_error_messages[:taken],
     product.errors.on(:title)
   end
end
