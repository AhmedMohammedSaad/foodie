import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import Stripe from "https://esm.sh/stripe@14.16.0"

serve(async (req) => {
  const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY") ?? "", {
    httpClient: Stripe.createFetchHttpClient(),
  })

  const signature = req.headers.get("stripe-signature")

  try {
    if (!signature) {
      throw new Error("Missing stripe-signature header")
    }

    const body = await req.text()
    const event = await stripe.webhooks.constructEventAsync(
      body,
      signature,
      Deno.env.get("STRIPE_WEBHOOK_SECRET") ?? ""
    )

    console.log(`Processing event: ${event.type}`)

    if (event.type === "payment_intent.succeeded") {
      const paymentIntent = event.data.object as Stripe.PaymentIntent
      const { user_id, restaurant_id, items } = paymentIntent.metadata
      const foodItems = JSON.parse(items)

      // Initialize Supabase Admin with Service Role Key for full DB access
      const supabaseAdmin = createClient(
        Deno.env.get("SUPABASE_URL") ?? "",
        Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
      )

      // 1. Create the Order
      // Using metadata passed from the create-payment-intent function
      const { data: order, error: orderError } = await supabaseAdmin
        .from("orders")
        .insert({
          user_id,
          restaurant_id,
          total_price: paymentIntent.amount / 100,
          items_count: foodItems.length,
          status: "confirmed", // Securely set to confirmed only after payment success
        })
        .select()
        .single()

      if (orderError) {
        console.error("Error creating order:", orderError)
        throw orderError
      }

      // 2. Create the Order Items
      const orderItems = foodItems.map((item: any) => ({
        order_id: order.id,
        food_id: item.food_id,
        quantity: item.quantity,
        price: item.price,
      }))

      const { error: itemsError } = await supabaseAdmin
        .from("order_items")
        .insert(orderItems)

      if (itemsError) {
        console.error("Error creating order items:", itemsError)
        throw itemsError
      }

      // 3. Create the Payment Record
      const { error: paymentError } = await supabaseAdmin
        .from("payments")
        .insert({
          order_id: order.id,
          stripe_payment_intent_id: paymentIntent.id,
          amount: paymentIntent.amount / 100,
          currency: paymentIntent.currency,
          status: "succeeded",
        })

      if (paymentError) {
        console.error("Error recording payment:", paymentError)
        throw paymentError
      }

      // 4. (Optional) Clear the user's cart
      await supabaseAdmin
        .from("cart_items")
        .delete()
        .eq("user_id", user_id)
      
      console.log(`Order ${order.id} successfully created via webhook.`)
    }

    return new Response(JSON.stringify({ received: true }), { 
      headers: { "Content-Type": "application/json" },
      status: 200 
    })

  } catch (error) {
    console.error(`Webhook Error: ${error.message}`)
    return new Response(
      JSON.stringify({ error: error.message }), 
      { 
        headers: { "Content-Type": "application/json" },
        status: 400 
      }
    )
  }
})
