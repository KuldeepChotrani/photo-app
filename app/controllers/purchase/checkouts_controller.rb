class Purchase::CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    price = params[:price_id]

    if current_user.country == "India"
        session = Stripe::Checkout::Session.create(
          customer: current_user.stripe_id,
          client_reference_id: current_user.id,
          success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: pricings_url,
          payment_method_types: ['card'],
          mode: 'subscription',
          customer_email: current_user.email,
          allow_promotion_codes: true,
          shipping_address_collection: {
            allowed_countries: ["IN"],
          },
          line_items: [{
            quantity: 1,
            price: price
          }]
        )
    else
      session = Stripe::Checkout::Session.create(
          customer: current_user.stripe_id,
          client_reference_id: current_user.id,
          success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: pricings_url,
          allow_promotion_codes: true,
          payment_method_types: ['card'],
          mode: 'subscription',
          customer_email: current_user.email,
          line_items: [{
            quantity: 1,
            price: price
          }]
        )
        end
    redirect_to session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = Stripe::Customer.retrieve(session.customer)
  end
end
