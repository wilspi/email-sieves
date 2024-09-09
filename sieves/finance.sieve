require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];
require "vnd.proton.expire";

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}


# Credit Cards
if address :matches "From" ["alerts@axisbank.com", "cards@icicibank.com", "cc.statements@axisbank.com", "credit_cards@icicibank.com", "creditcardalerts@kotak.com", "global@goniyo.com", "no-reply@goniyo.com", "notification@sbmbank.co.in", "statements@rblbank.com"]
{
    # Statements
    if anyof (header :comparator "i;unicode-casemap" :contains "Subject" ["statement", "e-statement"], address :matches "From" ["statements@rblbank.com", "global@goniyo.com", "cc.statements@axisbank.com", "cardstatement@kotak.com"])
    {
        fileinto "transactions/fin/cc-statements";
    }

    # Alerts/Transactions
    else
    {
        fileinto "transactions/fin/cc-alerts";
        expire "day" "300";
    }
}

# NPS
elsif address :matches "From" ["*@nsdl.co.in", "*@*proteantech.in"] {
    fileinto "transactions/fin/nps";
}

# Stocks, Mutual Funds
elsif address :matches "From" ["*@*.zerodha.net", "*@NSE.CO.IN", "*@alankit.com", "*@alankit.net", "*@bseindia.com", "*@bseindia.in", "*@camsonline.com", "*@cdslindia.co.in", "*@cdslindia.com", "*@edelweissfin.com", "*@edelweissmf.com", "*@kfintech.com", "*@kvbmail.com", "*@linkintime.co.in", "*@nsdl.com", "*@nse.co.in", "*@tcplindia.co.in", "AdvicesIN@sc.com", "InvestorServiceCentre@itclimited.in", "amararajabatteries@cameoindia.com", "cbkolcompliance@cbmsl.co", "clientservice@integratedindia.in", "clientservice@integratedregistry.in", "companysecretary@gravitaindia.com", "contact@skylinerta.co.in", "corporatenetbanking.automailer@hdfcbank.com", "cs@indiamart.com", "cs@polycab.com", "customersupport.icclmf@icclindia.com", "financialresults*@tatasteel.com", "green_bss@bigshareonline.com", "icash_cms@idbibank.com", "info@southindianbank.co.in", "investor.relations@jfs.in", "investor.relations@ril.com", "investors@datamaticsrta.com", "newsletter@briskmailer.in", "no-reply@skylinerta.co.in", "noreply@beetalfinancial.in", "support@purvashare.com", "trslagm2024@mdplcorporate.com"] {
    fileinto "transactions/fin/stocks-mfs";
}

# Smallcase
elsif address :matches "From" ["*@smallcase.com"] {
    fileinto "transactions/fin/smallcase";
}

# Loans
elsif address :matches "From" ["statements@hdfcbank.net", "customer.service@hdfc.com"] {
    fileinto "transactions/fin/loans";
}

# Payments
elsif address :matches "From" ["*@*.paypal.com", "*@mobikwik.com", "*@paytm.com", "*@paytmbank.com", "*@razorpay.com"] {
    fileinto "transactions/fin/payments";
}

# Rewards
elsif address :matches "From" ["no-reply@poshvine.com", "coupons@ihcltata.com"] {
    fileinto "transactions/fin/payments";
}

# Insurance
elsif address :matches "From" ["*@maxlifeinsurance.net", "*@maxlifeinsurance.com"] {
    fileinto "transactions/fin/insurance";
}

# Tax
elsif address :matches "From" ["tds.certificate@kotak.com"] {
    fileinto "transactions/fin/tax";
}

# Banks
elsif address :matches "From" ["*@federalbank.co.in", "*@fi.care", "*@fi.money", "*@hdfcbank.net", "*@kotak.com", "*@kotak.in", "*@sbmbank.co.in"] {
    fileinto "transactions/fin/banks";
}

