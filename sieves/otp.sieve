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
