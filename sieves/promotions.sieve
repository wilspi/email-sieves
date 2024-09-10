require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];

# Generated: Do not run this script on spam messages
if allof (
    environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}"
) {
    return;
}

# Newsletters
if address :matches "From" ["noreply-finshots@newsletter.zerodha.net", "james@jamesclear.com", "warikoowanderings@ankurwarikoo.com", "premium@capitalmind.in"] {
    fileinto "newsletters";
}

# Marketing Emails
elsif anyof (
    header :contains "List-Unsubscribe" "",
    header :contains "List-ID" "@",
    header :contains "X-Campaign-ID" ""
    # address :matches "From" ["noreply@steampowered.com", "marketing@royalbrothers.com", "*@communication.dspim.com", "YONOSBI@communications.sbi.co.in", "marketing@scoutapm.com", "noreply@alerts.sbi.co.in", "sbi@communications.sbi.co.in", "TataCLiQ@mall.tatacliq.com", "noreply@newsletter.zerodha.net", "amc@motilaloswal.com", "feedback@kotakbank.in", "no-reply@entertainment.bookmyshow.com", "noreply@paytmoffers.in", "noreply@axismf.com", "wealthsetsyoufree@mf.nipponindiaim.in", "info@mailer.smallcase.com", "noreply@miraeassetmf.co.in", "mfmarketing@invesco.com", "mfservice@motilaloswal.com", "alerts@nse.co.in", "communications@edelweissmf.com", "feedback@india.litmusworld.net", "investors@routemobile.com", "noreply@mailers.zomato.com", "noreply@sbmbank.co.in", "noreply@phonepe.com", "retailproducts@kotak.in"]
    # header :contains "Subject" ["sale", "offer", "discount", "promotion", "free", "limited time"],
    # header :contains "Precedence" ["bulk", "list"],
    # header :contains "X-Mailer" ["Mailchimp", "SendGrid", "Campaign Monitor"],
) {
    fileinto "Promotions - label";  # Add label
}

