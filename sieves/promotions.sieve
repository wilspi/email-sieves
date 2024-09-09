require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

# Promotions
if address :matches "From" ["TataCLiQ@mall.tatacliq.com", "noreply@newsletter.zerodha.net", "amc@motilaloswal.com", "feedback@kotakbank.in", "no-reply@entertainment.bookmyshow.com", "noreply@paytmoffers.in", "noreply@axismf.com", "wealthsetsyoufree@mf.nipponindiaim.in", "info@mailer.smallcase.com", "noreply@miraeassetmf.co.in", "mfmarketing@invesco.com", "mfservice@motilaloswal.com", "alerts@nse.co.in", "communications@edelweissmf.com", "feedback@india.litmusworld.net", "investors@routemobile.com", "noreply@mailers.zomato.com", "noreply@sbmbank.co.in", "noreply@phonepe.com", "retailproducts@kotak.in"] {
    fileinto "promotions";
}

# Newsletters
elsif address :matches "From" ["noreply-finshots@newsletter.zerodha.net"] {
    fileinto "newsletters";
}

# Ads
# if exists "list-unsubscribe"
# {
#    fileinto "advertisements";
# }

