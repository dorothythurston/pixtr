class ChargesController < ApplicationController
  def new
  end

  def create
    charge = Charge.new(current_user, params[:stripeToken])
    charge.process
    current_user.upgrade(customer.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
