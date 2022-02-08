require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    # validation tests/examples here
    describe 'Product' do
      it 'saves a new product if all four fields are valid' do
        @category = Category.new(name:"Home Decor")
        @product = Product.new(name: 'Vase', price_cents: 15000, quantity:12, category_id:@category.id)
        @product.save

        expect(@product.name).to eq('Vase')
        expect(@product.price_cents).to eq(15000)
        expect(@product.quantity).to eq(12)
        expect(@product.category_id).to eq(@category.id)
      end
    end

    describe 'Product' do
      it 'invalid when name is missing' do
        @category = Category.new(name:"Home Decor")
        @product = Product.new(name: nil, price_cents: 15000, quantity:12, category_id:@category.id)
        @product.save

        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'Product' do
      it 'invalid when price is missing' do
        @category = Category.new(name:"Home Decor")
        @product = Product.new(name: 'Vase', price_cents: nil, quantity:12, category_id:@category.id)
        @product.save

        expect(@product.errors.full_messages).to include("Price is not a number")
      end
    end

    describe 'Product' do
      it 'invalid when category is missing' do
        @category = Category.new(name:"Home Decor")
        @product = Product.new(name: 'Vase', price_cents: 15000, quantity:12, category_id: nil)
        @product.save

        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

    describe 'Product' do
      it 'invalid when quantity is missing' do
        @category = Category.new(name:"Home Decor")
        @product = Product.new(name: 'Vase', price_cents: 15000, quantity: nil, category_id:@category.id)
        @product.save

        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

  end
end
