require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];

# Moves emails to "transactions > sub-folders" 

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}


if anyof (address :all :comparator "i;unicode-casemap" :matches "From" ["noreply@zomato.com", "do-not-reply@dominos.co.in"]) {
    fileinto "transactions/food";
}

if allof (address :all :comparator "i;unicode-casemap" :matches "From" ["no-reply@paytm.com", "statements@rblbank.com"], header :comparator "i;unicode-casemap" :contains "Subject" ["Bill Payment", "Credit Card"]) {
    fileinto "transactions/cc bills";
}

if anyof (address :all :comparator "i;unicode-casemap" :matches "From" ["msedcl_ebill@mahadiscom.in", "eBill@Jio.com", "notifications_jiofiber@jio.com", "Notification@jio.com", "ebill@airtel.com"]) {
    fileinto "transactions/subscriptions";
}

if anyof (address :all :comparator "i;unicode-casemap" :matches "From" ["auto-confirm@amazon.in", "donotreply@busgst.in", "express@airbnb.com", "tickets@bookmyshow.email", "bookmyshow@amazon.com", "support@royalbrothers.com", "caroline@indiahikes.com", "6EGSTInvoice@goindigo.in", "no-reply-flights@amazon.com", "reservations@customer.goindigo.in"]) {
    fileinto "transactions/recreation";
}

if anyof (address :all :comparator "i;unicode-casemap" :matches "From" "no-reply@wakefit.co") {
    fileinto "transactions/shopping - LTS";
}

if anyof (address :all :comparator "i;unicode-casemap" :matches "From" "updates@myntra.com") {
    fileinto "transactions/shopping";
}

if anyof (address :all :comparator "i;unicode-casemap" :matches "From" ["no-reply@razorpay.com", "no-reply@paytmbank.com"]) {
    fileinto "transactions/payments";
}

if anyof (address :all :comparator "i;unicode-casemap" :matches "From" ["shoutout@rapido.bike", "noreply@olacabs.com", "noreply@olamoney.com"]) {
    fileinto "transactions/commute";
}
