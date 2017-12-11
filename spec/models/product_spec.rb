require 'rails_helper'
RSpec.describe Product, type: :model do
  before(:all) do
    @category = Category.find_or_create_by! name:"Music"


    @product = Product.new
    @product.name = "Hawt Pantz"
    @product.description ="Pants that will always stay at a toasty 40 degrees C"
    @product.category = @category
    @product.quantity = 12
    @product.price= 10.00
  end
  describe 'Validations' do
    # validation tests/examples here
    it "Category is valid with valid constructor" do
      expect(@category).to be_valid
      expect(@category.save).to be(true)
    end

    it "Product is valid with valid constructor" do
      expect(@product).to be_valid
      expect(@product.save).to be(true)
    end


  end

end
