class Product < ApplicationRecord
    validates :name, :price, presence: true
    validates :price, numericality: {greater_than: 0, less_than: 10000000}
  
    after_create do
        product = Stripe::Product.create(name: name)
        price = Stripe::Price.create(product: product, unit_amount: self.price, currency: self.currency)
        update(stripe_product_id: product.id, stripe_price_id: price.id)
      end
    
end
