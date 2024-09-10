require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];
require "vnd.proton.expire";

# Generated: Do not run this script on spam messages
if allof (
    environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}"
) {
    return;
}

# OTPs
if header :contains "Subject" ["OTP", "One Time Password"] {
    fileinto "transactions/otp";
    expire "day" "10";
}

# Newsletters
elsif address :matches "From" ["noreply-finshots@newsletter.zerodha.net", "james@jamesclear.com", "warikoowanderings@ankurwarikoo.com", "premium@capitalmind.in"] {
    fileinto "newsletters";
}

# Delete mails
elsif address :matches "From" ["no-reply@accounts.google.com", "auth@mailer.zerodha.net", "updates-noreply@linkedin.com", "services@cdslindia.co.in"] {
    fileinto "trash";
}

# Food transactions
elsif address :matches "From" ["noreply@zomato.com", "do-not-reply@dominos.co.in"] {
    fileinto "transactions/food";
    expire "day" "100";
}

# Bills and subscriptions
elsif address :matches "From" ["msedcl_ebill@mahadiscom.in", "eBill@Jio.com", "notifications_jiofiber@jio.com", "Notification@jio.com", "ebill@airtel.com"] {
    fileinto "transactions/subscriptions";
}

# Movies, Travel, and Recreation
elsif address :matches "From" ["auto-confirm@amazon.in", "donotreply@busgst.in", "express@airbnb.com", "tickets@bookmyshow.email", "bookmyshow@amazon.com", "support@royalbrothers.com", "caroline@indiahikes.com", "6EGSTInvoice@goindigo.in", "no-reply-flights@amazon.com", "reservations@customer.goindigo.in"] {
    fileinto "transactions/recreation";
}

# Shopping transactions - Long term storage
elsif address :matches "From" ["no-reply@wakefit.co"] {
   fileinto "transactions/shopping-lts";
}

# Shopping transactions
elsif address :matches "From" ["auto-confirm@amazon.in", "updates@myntra.com", "shipment-tracking@amazon.in", "order-update@amazon.in", "*@marketplace.amazon.in"] {
    fileinto "transactions/shopping";
    expire "day" "300"; # Delete after 300 days
}

# Commute transactions - Uber, Olacabs, Rapido
elsif address :matches "From" ["shoutout@rapido.bike", "noreply@olacabs.com", "noreply@olamoney.com"] {
    fileinto "transactions/commute";
    expire "day" "100";
}

# Updates
elsif address :matches "From" ["hello@producthunt.com", "notifications@github.com", "noreply@github.com", "service@report-uri.com", "no-reply@leetcode.com"] {
    fileinto "dev/updates";
}

# Interviews, Job applications
elsif address :matches "From" ["*@tophire.co", "*@naukri.com"] {
    fileinto "work/interviews";
}


# Credit Cards
elsif address :matches "From" ["alerts@axisbank.com", "cards@icicibank.com", "cc.statements@axisbank.com", "credit_cards@icicibank.com", "creditcardalerts@kotak.com", "global@goniyo.com", "no-reply@goniyo.com", "notification@sbmbank.co.in", "statements@rblbank.com"]
{
    # Statements
    if anyof (
        header :contains "Subject" ["statement", "e-statement"],
        address :matches "From" ["statements@rblbank.com", "global@goniyo.com", "cc.statements@axisbank.com", "cardstatement@kotak.com"]
    ) {
        fileinto "transactions/fin/cc-statements";
    }

    # Alerts/Transactions
    else
    {
        fileinto "transactions/fin/cc-alerts";
        expire "day" "100";
    }
}

# NPS
elsif address :matches "From" ["*@nsdl.co.in", "*@*proteantech.in"] {
    fileinto "transactions/fin/nps";
}

# Stocks, Mutual Funds
elsif address :matches "From" ["*@cdslstatement.com", "*@*.zerodha.net", "*@NSE.CO.IN", "*@alankit.com", "*@alankit.net", "*@bseindia.com", "*@bseindia.in", "*@camsonline.com", "*@cdslindia.co.in", "*@cdslindia.com", "*@edelweissfin.com", "*@edelweissmf.com", "*@kfintech.com", "*@kvbmail.com", "*@linkintime.co.in", "*@nsdl.com", "*@nse.co.in", "*@tcplindia.co.in", "AdvicesIN@sc.com", "InvestorServiceCentre@itclimited.in", "amararajabatteries@cameoindia.com", "cbkolcompliance@cbmsl.co", "clientservice@integratedindia.in", "clientservice@integratedregistry.in", "companysecretary@gravitaindia.com", "contact@skylinerta.co.in", "corporatenetbanking.automailer@hdfcbank.com", "cs@indiamart.com", "cs@polycab.com", "customersupport.icclmf@icclindia.com", "financialresults*@tatasteel.com", "green_bss@bigshareonline.com", "icash_cms@idbibank.com", "info@southindianbank.co.in", "investor.relations@jfs.in", "investor.relations@ril.com", "investors@datamaticsrta.com", "newsletter@briskmailer.in", "no-reply@skylinerta.co.in", "noreply@beetalfinancial.in", "support@purvashare.com", "trslagm2024@mdplcorporate.com"] {
    fileinto "transactions/fin/stocks-mfs";
    expire "day" "400";
}

# Smallcase
elsif address :matches "From" ["*@smallcase.com", "smallcase@capitalmind.in"] {
    fileinto "transactions/fin/smallcase";
}

# Loans
elsif address :matches "From" ["statements@hdfcbank.net", "customer.service@hdfc.com"] {
    fileinto "transactions/fin/loans";
}

# Payments
elsif address :matches "From" ["*@*.paypal.com", "*@mobikwik.com", "*@paytm.com", "*@paytmbank.com", "*@razorpay.com", "*@amazonpay.in"] {
    fileinto "transactions/fin/payments";
}

# Rewards
elsif address :matches "From" ["no-reply@poshvine.com", "coupons@ihcltata.com"] {
    fileinto "transactions/fin/payments";
}

# Insurance
elsif address :matches "From" ["*@maxlifeinsurance.net", "*@maxlifeinsurance.com", "*@acko.com"] {
    fileinto "transactions/fin/insurance";
}

# Tax
elsif address :matches "From" ["tds.certificate@kotak.com"] {
    fileinto "transactions/fin/tax";
}

# Banks
elsif address :matches "From" ["*@federalbank.co.in", "*@fi.care", "*@fi.money", "*@hdfcbank.net", "*@kotak.com", "*@kotak.in", "*@sbmbank.co.in", "cbssbi.cas@alerts.sbi.co.in"] {
    fileinto "transactions/fin/banks";
}


# Marketing Emails
elsif anyof (
    header :contains "List-Unsubscribe" "",
    header :contains "List-ID" "@",
    header :contains "X-Campaign-ID" ""
    # address :matches "From" ["marketing@royalbrothers.com", "*@communication.dspim.com", "YONOSBI@communications.sbi.co.in", "marketing@scoutapm.com", "noreply@alerts.sbi.co.in", "sbi@communications.sbi.co.in", "TataCLiQ@mall.tatacliq.com", "noreply@newsletter.zerodha.net", "amc@motilaloswal.com", "feedback@kotakbank.in", "no-reply@entertainment.bookmyshow.com", "noreply@paytmoffers.in", "noreply@axismf.com", "wealthsetsyoufree@mf.nipponindiaim.in", "info@mailer.smallcase.com", "noreply@miraeassetmf.co.in", "mfmarketing@invesco.com", "mfservice@motilaloswal.com", "alerts@nse.co.in", "communications@edelweissmf.com", "feedback@india.litmusworld.net", "investors@routemobile.com", "noreply@mailers.zomato.com", "noreply@sbmbank.co.in", "noreply@phonepe.com", "retailproducts@kotak.in"]
    # header :contains "Subject" ["sale", "offer", "discount", "promotion", "free", "limited time"],
    # header :contains "Precedence" ["bulk", "list"],
    # header :contains "X-Mailer" ["Mailchimp", "SendGrid", "Campaign Monitor"],
) {
    fileinto "Promotions - label";  # Add label
}


