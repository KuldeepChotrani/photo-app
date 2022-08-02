Rails.configuration.stripe = {

:publishable_key => ENV['api_key'],

:secret_key => ENV['api_key']

}

Stripe.api_key = ENV['api_key']