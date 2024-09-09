require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];
require "vnd.proton.expire";

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

if address :matches "From" ["no-reply@accounts.google.com", "auth@mailer.zerodha.net"] {
    fileinto "trash";
}

# Stocks, Mutual Funds
elsif address :matches "From" ["*@*.zerodha.net", "*@NSE.CO.IN", "*@alankit.com", "*@alankit.net", "*@bseindia.com", "*@bseindia.in", "*@camsonline.com", "*@cdslindia.co.in", "*@cdslindia.com", "*@edelweissfin.com", "*@edelweissmf.com", "*@kfintech.com", "*@kvbmail.com", "*@linkintime.co.in", "*@nsdl.com", "*@nse.co.in", "*@tcplindia.co.in", "AdvicesIN@sc.com", "InvestorServiceCentre@itclimited.in", "amararajabatteries@cameoindia.com", "cbkolcompliance@cbmsl.co", "clientservice@integratedindia.in", "clientservice@integratedregistry.in", "companysecretary@gravitaindia.com", "contact@skylinerta.co.in", "corporatenetbanking.automailer@hdfcbank.com", "cs@indiamart.com", "cs@polycab.com", "customersupport.icclmf@icclindia.com", "financialresults*@tatasteel.com", "green_bss@bigshareonline.com", "icash_cms@idbibank.com", "info@southindianbank.co.in", "investor.relations@jfs.in", "investor.relations@ril.com", "investors@datamaticsrta.com", "newsletter@briskmailer.in", "no-reply@skylinerta.co.in", "noreply@beetalfinancial.in", "support@purvashare.com", "trslagm2024@mdplcorporate.com"] {
    expire "day" "400";
}

# Smallcase
elsif address :matches "From" ["*@smallcase.com"] {
    expire "day" "300";
}
