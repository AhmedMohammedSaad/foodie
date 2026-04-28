import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import Stripe from "https://esm.sh/stripe@14.16.0"

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders })
  }

  try {
    const { items, restaurant_id, user_id } = await req.json()

    if (!items || !items.length) {
      throw new Error("No items in cart")
    }

    // 1. Initialize Supabase Admin client (Service Role)
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    )

    // 2. Initialize Stripe
    const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY") ?? "", {
      httpClient: Stripe.createFetchHttpClient(),
    })

    // 3. Recalculate total price securely on server
    // We fetch prices from the database for each food item to prevent spoofing
    let totalPrice = 0
    const foodItemsData = []

    for (const item of items) {
      const itemId = item.id || item.food_id
      const { data: food, error } = await supabaseClient
        .from("foods")
        .select("id, price, name")
        .eq("id", itemId)
        .single()

      if (error || !food) {
        throw new Error(`Item not found: ${itemId}`)
      }

      totalPrice += Number(food.price) * item.quantity
      foodItemsData.push({
        food_id: food.id,
        quantity: item.quantity,
        price: food.price
      })
    }

    // Stripe uses cents/smallest currency unit
    const amountInCents = Math.round(totalPrice * 100)

    // 4. Create PaymentIntent
    // We store the cart details in metadata so the Webhook can recover them
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amountInCents,
      currency: "usd",
      metadata: {
        user_id,
        restaurant_id,
        items: JSON.stringify(foodItemsData),
      },
    })

    return new Response(
      JSON.stringify({ 
        clientSecret: paymentIntent.client_secret,
        publishableKey: Deno.env.get("STRIPE_PUBLISHABLE_KEY")
      }),
      { 
        headers: { ...corsHeaders, "Content-Type": "application/json" }, 
        status: 200 
      }
    )

  } catch (error) {
    console.error("Error creating payment intent:", error.message)
    return new Response(
      JSON.stringify({ error: error.message }),
      { 
        headers: { ...corsHeaders, "Content-Type": "application/json" }, 
        status: 400 
      }
    )
  }
})
