require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];

# Generated: Do not run this script on spam messages
if allof (
    environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}"
) {
    return;
}

# Updates
if address :matches "From" ["hello@producthunt.com", "notifications@github.com", "noreply@github.com", "service@report-uri.com", "no-reply@leetcode.com"] {
    fileinto "dev/updates";
}

# Interviews, Job applications
elsif address :matches "From" ["*@tophire.co", "*@naukri.com"] {
    fileinto "work/interviews";
}