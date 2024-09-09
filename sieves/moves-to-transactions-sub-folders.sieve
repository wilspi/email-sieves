require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];
require "vnd.proton.expire";

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

if address :matches "From" ["noreply@zomato.com", "do-not-reply@dominos.co.in"] {
    fileinto "transactions/food";
    expire "day" "100";
}

elsif address :matches "From" ["msedcl_ebill@mahadiscom.in", "eBill@Jio.com", "notifications_jiofiber@jio.com", "Notification@jio.com", "ebill@airtel.com"] {
    fileinto "transactions/subscriptions";
}

elsif address :matches "From" ["auto-confirm@amazon.in", "donotreply@busgst.in", "express@airbnb.com", "tickets@bookmyshow.email", "bookmyshow@amazon.com", "support@royalbrothers.com", "caroline@indiahikes.com", "6EGSTInvoice@goindigo.in", "no-reply-flights@amazon.com", "reservations@customer.goindigo.in"] {
    fileinto "transactions/recreation";
}

elsif address :matches "From" ["no-reply@wakefit.co"] {
   fileinto "transactions/shopping-lts";
}

elsif address :matches "From" ["updates@myntra.com"] {
    fileinto "transactions/shopping";
    expire "day" "300";
}

elsif address :matches "From" ["shoutout@rapido.bike", "noreply@olacabs.com", "noreply@olamoney.com"] {
    fileinto "transactions/commute";
    expire "day" "100";
}

elsif header :comparator "i;unicode-casemap" :contains "Subject" ["OTP", "One Time Password"] {
    fileinto "transactions/otp";
    expire "day" "10";
}
