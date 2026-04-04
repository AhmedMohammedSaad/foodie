Title: Get payment methods (Step 1)

URL Source: http://fawaterak-api.readme.io/reference/initiatepayment

Markdown Content:
Endpoint

This is your first step for integration , you will send request for our end point to receive the payment methods which assigned to you.

The "InitiatePayment" endpoint is a GET request. It is used to retrieve all enabled Payment Methods of your portal account with the commission charge that the customer may pay on the gateway.

PLEASE USE THE BELOW END POINT:

[https://staging.fawaterk.com/api/v2/getPaymentmethods](https://staging.fawaterk.com/api/v2/getPaymentmethods)

also below is sample request and response codes

```
<?php
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://staging.fawaterk.com/api/v2/getPaymentmethods',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd'
  ),
));
$response = curl_exec($curl);
curl_close($curl);
```

```
var client = new RestClient("https://staging.fawaterk.com/api/v2/getPaymentmethods");
client.Timeout = -1;
var request = new RestRequest(Method.GET);
request.AddHeader("content-type", "application/json");
request.AddHeader("Authorization", "Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd");
IRestResponse response = client.Execute(request);
Console.WriteLine(response.Content);
```

```
var myHeaders = new Headers();
myHeaders.append("content-type", "application/json");
myHeaders.append("Authorization", "Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd");

var requestOptions = {
  method: 'GET',
  headers: myHeaders,
  redirect: 'follow'
};

fetch("https://staging.fawaterk.com/api/v2/getPaymentmethods", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

```
import requests
import json

url = "https://staging.fawaterk.com/api/v2/getPaymentmethods"

payload={}
headers = {
  'content-type': 'application/json',
  'Authorization': 'Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd'
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
import requests
import json

url = "https://dev.fawaterk.com/api/v2/getPaymentmethods"

payload={}
headers = {
  'content-type': 'application/json',
  'Authorization': 'Bearer 0b3fefb44fd628870b751793224d6334fea5d38300641e36aa'
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
```

Response Body

```
{
    "status": "success",
    "data": [
        {
            "paymentId": 2,
            "name_en": "Visa-Mastercard",
            "name_ar": "فيزا -ماستر كارد",
            "redirect": "true",
            "logo": "https://app.fawaterak.xyz/clients/payment_options/mastercard-visa.png"
        },
        {
            "paymentId": 3,
            "name_en": "Fawry",
            "name_ar": "فوري",
            "redirect": "false",
            "logo": "https://app.fawaterak.xyz/clients/payment_options/fawry.png"
        },
        {
            "paymentId": 4,
            "name_en": "Meeza",
            "name_ar": "ميزا",
            "redirect": "false",
            "logo": "https://app.fawaterak.xyz/clients/payment_options/MeezaDigitalSmall.png"
        }
     
    ]
}
```

1.please note that if redirect attribute equal to "TRUE" then you will receive a link you need to redirect to it to complete the payment process.

2.Kindly note that Meeza (Mobile wallets ) tested by real payments only.

*   [Table of Contents](http://fawaterak-api.readme.io/reference/initiatepayment#)
*       *   [IMPORTANT NOTES](http://fawaterak-api.readme.io/reference/initiatepayment#important-notes)

Title: Execute Payment (Step 2)

URL Source: http://fawaterak-api.readme.io/reference/inetail-payment-1

Markdown Content:
# Execute Payment (Step 2)

[Jump to Content](http://fawaterak-api.readme.io/reference/inetail-payment-1#content)

[![Image 1: Fawaterak API](https://files.readme.io/b41ddf580e4e9e8aa9996bf88066ec5ae942379ac13a6983f790239fbef2ebd6-small-Asset_34x.png)](http://fawaterak-api.readme.io/reference)

[API Reference](http://fawaterak-api.readme.io/reference)

v1.0

* * *

[Log In](http://fawaterak-api.readme.io/login?redirect_uri=/reference/inetail-payment-1)[![Image 2: Fawaterak API](https://files.readme.io/b41ddf580e4e9e8aa9996bf88066ec5ae942379ac13a6983f790239fbef2ebd6-small-Asset_34x.png)](http://fawaterak-api.readme.io/reference)

API Reference

[Log In](http://fawaterak-api.readme.io/login?redirect_uri=/reference/inetail-payment-1)

v1.0[API Reference](http://fawaterak-api.readme.io/reference)Execute Payment (Step 2)

Search

All

Reference

###### Start typing to search…

JUMP TO CTRL-/

## Fawaterak API

*   [Overview](http://fawaterak-api.readme.io/reference/overview)
*   [Getting Started With Your API](http://fawaterak-api.readme.io/reference/getting-started-with-your-api)
*   [Test account](http://fawaterak-api.readme.io/reference/test-token)
    *   [Test Cards](http://fawaterak-api.readme.io/reference/test-cards)

*   [Payment Methods](http://fawaterak-api.readme.io/reference/payment-methods)
*   [Live Account](http://fawaterak-api.readme.io/reference/live-account)

## TECHNICAL GUIDE

*   [Fawaterak IFrame](http://fawaterak-api.readme.io/reference/fawaterk-hosted-checkout)
*   [Create e-invoice Link](http://fawaterak-api.readme.io/reference/invoice-link)
    *   [Send Payment](http://fawaterak-api.readme.io/reference/sendpayment)

*   [Gateway Integration](http://fawaterak-api.readme.io/reference/gateway-integration)
    *   [Get payment methods (Step 1)](http://fawaterak-api.readme.io/reference/initiatepayment)
    *   [Execute Payment (Step 2)](http://fawaterak-api.readme.io/reference/inetail-payment-1)

*   [Pay with tokenization or recurring](http://fawaterak-api.readme.io/reference/pay-with-tokenization)
*   [Get Transaction Data](http://fawaterak-api.readme.io/reference/get-transaction-data)
*   [Web Hook](http://fawaterak-api.readme.io/reference/web-hook)
*   [E-Commerce Plugins](http://fawaterak-api.readme.io/reference/e-commerce-plugins)
*   [Mobile Integration](http://fawaterak-api.readme.io/reference/mobile-sdks)
    *   [Retrieve Available Payment Methods (Step 1)](http://fawaterak-api.readme.io/reference/retrieve-available-payment-methods-step-1-copy)
    *   [Initiate and Process Payments (Step 2)](http://fawaterak-api.readme.io/reference/initiate-and-process-payments-step-2)
    *   [Example of Usage](http://fawaterak-api.readme.io/reference/usage-example)

Powered by[](https://readme.com/?ref_src=hub&project=fawaterak-api)

# Execute Payment (Step 2)

Ask AI

EndPoint

Initiate Payment request

 The "ExecutePayment" endpoint is a POST request.

 It is used to create a Fawaterak transaction on the selected gateway.

## Here is a sample code :

[](http://fawaterak-api.readme.io/reference/inetail-payment-1#here-is-a-sample-code-)

PHP.NET JavaScript Python

```php
<?php
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://staging.fawaterk.com/api/v2/invoiceInitPay',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "payment_method_id": 2,
    "cartTotal": "50",
    "currency": "EGP",
    "invoice_number" : "123",
    "customer": {
        "first_name": "mohammad",
        "last_name": "hamza",
        "email": "test@fawaterk.com",
        "phone": "01xxxxxxxxx",
        "address": "test address"
    },
    "redirectionUrls": {
         "successUrl" : "https://dev.fawaterk.com/success",
         "failUrl": "https://dev.fawaterk.com/fail",
         "pendingUrl": "https://dev.fawaterk.com/pending"   
    },
    "cartItems": [
        {
            "name": "this is test oop 112252",
            "price": "25",
            "quantity": "1"
        },
        {
            "name": "this is test oop 112252",
            "price": "25",
            "quantity": "1"
        }
    ]
}',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json',
    'Authorization: Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd'
  ),
));
$response = curl_exec($curl);
curl_close($curl);
```

```csharp
var client = new RestClient("https://staging.fawaterk.com/api/v2/invoiceInitPay");
client.Timeout = -1;
var request = new RestRequest(Method.POST);
request.AddHeader("Authorization", "Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd");
request.AddHeader("Content-Type", "application/json");
var body = @"{" + "\n" +
@"    ""payment_method_id"": 4," + "\n" +
@"    ""cartTotal"": ""100""," + "\n" +
@"    ""currency"": ""EGP""," + "\n" +
@"    ""customer"": {" + "\n" +
@"        ""first_name"": ""test""," + "\n" +
@"        ""last_name"": ""test""," + "\n" +
@"        ""email"": ""test@test.com""," + "\n" +
@"        ""phone"": ""01000000000""," + "\n" +
@"        ""address"": ""test address""" + "\n" +
@"    }," + "\n" +
@"    ""redirectionUrls"": {" + "\n" +
@"        ""successUrl"": ""https://dev.fawaterk.com/success""," + "\n" +
@"        ""failUrl"": ""https://dev.fawaterk.com/fail""," + "\n" +
@"        ""pendingUrl"": ""https://dev.fawaterk.com/pending""" + "\n" +
@"    }," + "\n" +
@"    ""cartItems"": [" + "\n" +
@"        {" + "\n" +
@"            ""name"": ""test""," + "\n" +
@"            ""price"": ""100""," + "\n" +
@"            ""quantity"": ""1""" + "\n" +
@"        }" + "\n" +
@"    ]" + "\n" +
@"}";
request.AddParameter("application/json", body,  ParameterType.RequestBody);
IRestResponse response = client.Execute(request);
Console.WriteLine(response.Content);
```

```javascript
const payload = {
  payment_method_id: 4,
  cartTotal: "100",
  currency: "EGP",
  customer: {
    first_name: "test",
    last_name: "test",
    email: "test@test.test",
    phone: "01000000000",
    address: "test address",
  },
  redirectionUrls: {
    successUrl: "https://dev.fawaterk.com/success",
    failUrl: "https://dev.fawaterk.com/fail",
    pendingUrl: "https://dev.fawaterk.com/pending",
  },
  cartItems: [
    {
      name: "test",
      price: "100",
      quantity: "1",
    },
  ],
};

fetch("https://staging.fawaterk.com/api/v2/invoiceInitPay", {
  method: "POST",
  headers: {
    Authorization:
      "Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd",
    "Content-Type": "application/json",
  },
  body: JSON.stringify(payload),
})
  .then(function (response) {
    if (!response.ok) {
      return response.text().then(function (text) {
        throw new Error("HTTP " + response.status + ": " + text);
      });
    }
    return response.json();
  })
  .then(function (data) {
    console.log(JSON.stringify(data));
  })
  .catch(function (error) {
    console.log(error);
  });
```

```python
import requests
import json

url = "https://staging.fawaterk.com/api/v2/invoiceInitPay"

payload = json.dumps({
  "payment_method_id": 4,
  "cartTotal": "100",
  "currency": "EGP",
  "customer": {
    "first_name": "test",
    "last_name": "test",
    "email": "test@test.com",
    "phone": "01000000000",
    "address": "test address"
  },
  "redirectionUrls": {
    "successUrl": "https://dev.fawaterk.com/success",
    "failUrl": "https://dev.fawaterk.com/fail",
    "pendingUrl": "https://dev.fawaterk.com/pending"
  },
  "cartItems": [
    {
      "name": "test",
      "price": "100",
      "quantity": "1"
    }
  ]
})
headers = {
  'Authorization': 'Bearer d83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd',
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)
```

Initiate payment response

## 1. General Response For All Methods Except Methods Below

[](http://fawaterak-api.readme.io/reference/inetail-payment-1#1-general-response-for-all-methods-except-methods-below)

JSON

```json
{
    "status": "success",
    "data": {
        "invoice_id": 1000428,
        "invoice_key": "hyU2vcy3USvT5Tg",
        "payment_data": {
            "redirectTo": "https://staging.fawaterk.com/link/I0PAH"
        }
    }
}
```

## 2.Fawry Response

[](http://fawaterak-api.readme.io/reference/inetail-payment-1#2fawry-response)

JSON

```json
{
    "status": "success",
    "data": {
        "invoice_id": 1000425,
        "invoice_key": "QqgdnAB7Ad2kmIq",
        "payment_data": {
            "fawryCode": "981335305",
            "expireDate": "2021-07-06 15:53:41"
        }
    }
}
```

## 3.Mobile Wallet Response

[](http://fawaterak-api.readme.io/reference/inetail-payment-1#3mobile-wallet-response)

JSON

```json
{
    "status": "success",
    "data": {
        "invoice_id": 1000427,
        "invoice_key": "2vX8jSkmqbwJ4Ls",
        "payment_data": {
            "meezaReference": 4266311,
          "meezaQrCode":"00020101021226330016A00000073210000101096100559795204152053038185406106.565802EG5922Fawaterk Test Merchant6004Giza624505063424000105271000311116453477230707528640463047821"
        }
    }
}
```

## 4.Aman Response

[](http://fawaterak-api.readme.io/reference/inetail-payment-1#4aman-response)

JSON

```json
{
    "status": "success",
    "data": {
        "invoice_id": 1000424,
        "invoice_key": "QqgdnAB7Ad2kmIq",
        "payment_data": {
            "amanCode": "1478581"
        }
    }
}
```

## 5.Basta Response

[](http://fawaterak-api.readme.io/reference/inetail-payment-1#5basta-response)

JSON

```json
{
    "status": "success",
    "data": {
        "invoice_id": 1000426,
        "invoice_key": "QqgdnAB7Ad2kmIq",
        "payment_data": {
            "masaryCode": "1554222"
        }
    }
}
```

**Request parameters Ref.:**

| Parameter | Type | Description |  |
| --- | --- | --- | --- |
| payment_method_id | Int | id from Get payment methods (Step 1) | Mandatory |
| customer | Json object | Customer name which will applied in checkout page ( it's a Json object ) |  |
| invoice_number | String | You can use it as a reference at your system. | Optional |
| invoice_id | Int | For the first invoiceInitPay call, you will get a response with data.invoice_id, you can use it as invoice_id in the following requests to update the invoice and to not create new one. | Optional |
| customer.first_name | String | customer first name (alphanumeric @ - _ . ) | Mandatory |
| customer.last_name | String | customer last name (Mandatory) (alphanumeric @ - _ . ) | Mandatory |
| customer.email | String | customer email (Mandatory) | Optional |
| customer.phone | Int | customer mobile (Mandatory in case of Mobile Wallet payment method presented) | Optional |
| customer.address | String | customer address (alphanumeric @ - _ . , : ) | Optional |
| Cart Items | Json array | This contain your products/services which the customer buying it |  |
| cartitems.name | String | Product/service name | Mandatory |
| cartitems.price | decimal | Item price | Mandatory |
| cartitems.quantity | Integer | item quantity | Mandatory |
| cartTotal | decimal | cart total | Mandatory |
| currency | String | 'USD', 'EGP', 'SAR', 'AED', 'KWD', 'QAR', 'BHD' | Mandatory |
| frequency | String | 'once', 'weekly', 'biweekly', 'monthly', 'quarterly' Default:once | Optional |
| customExpireDate | String | +2 hours , +4 hours , +6 hours , +12 hours , +1 days , +2 days | Optional |
| discountData | JSON | Apply discount on the total amount | Optional |
| discountData.type | String | "pcg" (percentage) or "literal" (fixed value) |  |
| discountData.value | Number | value between 1 - 99 |  |
| taxData | JSON | Apply percentage discount | Optional |
| taxData.title | String | Name of the applied tax |  |
| taxData.value | Numeric | Percentage numeric value. |  |
| authAndCapture | Int | 0 or 1 | Optional |
| payLoad | Json | custom filed you can use if you need to connect sending data with receiving data after payment | Optional |
| mobileWalletNumber | Int | customer mobile wallet number using only with mobile wallet payment method | Optional |
| due_date | date Y-m-d | it's an optional field if you need | Optional |
| sendEmail | true/false | send invoice notification through an email to your customer | Optional |
| sendSMS | true/false | send invoice notification through SMS to your customer | Optional |
| lang | string | en/ar , default en. The language to show the payment process after redirection. | Optional |
| redirectOption | true/false | default false, this is to receive payment redirection URL regardless the payment method. So, you can redirect to Fawaterk to pay using Fawry code instead of handling show the code at your end. | Optional |
| redirectionUrls | Json object | links that system will redirect to after customer pay | Optional |
| redirectionUrls.successUrl | String | link will redirect to in case of payment process success | Optional |
| redirectionUrls.failUrl | String | link will redirect to in case of payment process fail | Optional |
| redirectionUrls.pendingUrl | String | this link using case customer choose to pay with payment methods like (fawry - aman) | Optional |
| redirectionUrls.webhookUrl | String | Custom paid webhook URL, it overrides the URL in Fawaterak dashboard | Optional |

Updated about 19 hours ago

* * *

[Get payment methods (Step 1)](http://fawaterak-api.readme.io/reference/initiatepayment)[Pay with tokenization or recurring](http://fawaterak-api.readme.io/reference/pay-with-tokenization)

Updated about 19 hours ago

* * *

[Get payment methods (Step 1)](http://fawaterak-api.readme.io/reference/initiatepayment)[Pay with tokenization or recurring](http://fawaterak-api.readme.io/reference/pay-with-tokenization)

*   [Table of Contents](http://fawaterak-api.readme.io/reference/inetail-payment-1#)
*       *   [Here is a sample code :](http://fawaterak-api.readme.io/reference/inetail-payment-1#here-is-a-sample-code-)
    *   [1. General Response For All Methods Except Methods Below](http://fawaterak-api.readme.io/reference/inetail-payment-1#1-general-response-for-all-methods-except-methods-below)
    *   [2.Fawry Response](http://fawaterak-api.readme.io/reference/inetail-payment-1#2fawry-response)
    *   [3.Mobile Wallet Response](http://fawaterak-api.readme.io/reference/inetail-payment-1#3mobile-wallet-response)
    *   [4.Aman Response](http://fawaterak-api.readme.io/reference/inetail-payment-1#4aman-response)
    *   [5.Basta Response](http://fawaterak-api.readme.io/reference/inetail-payment-1#5basta-response)

1.   Fawaterak API
2.   [Overview](http://fawaterak-api.readme.io/reference/overview)
3.   [Getting Started With Your API](http://fawaterak-api.readme.io/reference/getting-started-with-your-api)
4.   [Test account](http://fawaterak-api.readme.io/reference/test-token)
5.   [Test Cards](http://fawaterak-api.readme.io/reference/test-cards)
6.   [Payment Methods](http://fawaterak-api.readme.io/reference/payment-methods)
7.   [Live Account](http://fawaterak-api.readme.io/reference/live-account)

1.   TECHNICAL GUIDE
2.   [Fawaterak IFrame](http://fawaterak-api.readme.io/reference/fawaterk-hosted-checkout)
3.   [Create e-invoice Link](http://fawaterak-api.readme.io/reference/invoice-link)
4.   [Send Payment](http://fawaterak-api.readme.io/reference/sendpayment)
5.   [Gateway Integration](http://fawaterak-api.readme.io/reference/gateway-integration)
6.   [Execute Payment (Step 2)](http://fawaterak-api.readme.io/reference/inetail-payment-1)
7.   [Get payment methods (Step 1)](http://fawaterak-api.readme.io/reference/initiatepayment)
8.   [Pay with tokenization or recurring](http://fawaterak-api.readme.io/reference/pay-with-tokenization)
9.   [Get Transaction Data](http://fawaterak-api.readme.io/reference/get-transaction-data)
10.   [Web Hook](http://fawaterak-api.readme.io/reference/web-hook)
11.   [E-Commerce Plugins](http://fawaterak-api.readme.io/reference/e-commerce-plugins)
12.   [Mobile Integration](http://fawaterak-api.readme.io/reference/mobile-sdks)
13.   [Example of Usage](http://fawaterak-api.readme.io/reference/usage-example)
14.   [Initiate and Process Payments (Step 2)](http://fawaterak-api.readme.io/reference/initiate-and-process-payments-step-2)
15.   [Retrieve Available Payment Methods (Step 1)](http://fawaterak-api.readme.io/reference/retrieve-available-payment-methods-step-1-copy)