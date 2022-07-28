class PricingsController < ApplicationController

    def show
    end
    def index
        @pricing= Stripe::Price.list({limit: 10})
        price = params[:price_id]
    end
end