require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];

# Generated: Do not run this script on spam messages
if allof (
    environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}"
) {
    return;
}

if anyof (
    address :matches ["To", "Cc", "Bcc"] ["wilspionline@gmail.com", "wilspi.online@gmail.com"],
    address :matches "From" ["wilspionline*", "wilspi.online*"]
) {
    fileinto "\"wilspi.online\" - forward";
}

if anyof (
    address :matches ["To", "Cc", "Bcc"] ["thewilspi@gmail.com", "the.wilspi@gmail.com"],
    address :matches "From" ["thewilspi*", "the.wilspi*"]
) {
    fileinto "\"thewilspi\" - forward";
}
