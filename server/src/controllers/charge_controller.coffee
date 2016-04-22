lodash = require 'lodash'

module.exports = do ->

  post: (req, res) ->
    stripe = require('stripe')('sk_test_pWy8lKC1ZXDI29NCbATR3fs9')
    stripeToken = req.body.stripeToken
    console.log req.body
    charge = stripe.charges.create({
      amount: 999
      currency: "usd"
      source: stripeToken
      description: "Example charge"
    }, (err, charge) ->
      if err && err.type is 'StripeCardError'
        console.log 'card was declined'
        res.status 400
        res.send 'card was declined'
      else
        # TODO: Create a "page" entry using the req.body.page
        # TODO: associate a random password to the page
        # TODO: Send out an email to the user with their new page information & password
        # TODO: Send back the random password and page.id
        console.log 'card accepted'
        res.status 200
        res.send 'success'
    )
