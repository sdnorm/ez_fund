class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    event = Stripe::Event.construct_from(params.as_json)

    case event.type
    when "checkout.session.completed"
      handle_checkout_session_completed(event.data.object)
    end

    head :ok
  end

  private

  def handle_checkout_session_completed(session)
    # Find the purchase and update its status
    purchase = Purchase.find_by(stripe_payment_intent_id: session.payment_intent)
    purchase.update!(status: "completed")
    purchase.calendar_day.update!(status: "purchased")
  end
end
