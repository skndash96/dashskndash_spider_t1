# Cybersecurity Basic Deliverables

1. Public Documents (PDF, XLSX, DOCX, etc.)
General Documents:
site:tesla.com filetype:pdf OR filetype:xlsx OR filetype:docx OR filetype:pptx
Specific Document Types with Keywords:
site:tesla.com filetype:pdf "report"
site:tesla.com filetype:xlsx "employee"
site:tesla.com filetype:docx "confidential"

2. Login Pages / Admin Panels
site:tesla.com inurl:login | inurl:admin | inurl:wp-admin | inurl:user | inurl:signin | intitle:login | intitle:admin
Specific Admin Panel Names
site:tesla.com inurl:admin
Looking for Login Forms:
site:tesla.com intext:"username" intext:"password" "login"

3. Public Backup / Config Filessite:tesla.com inurl:backup | inurl:.bak | inurl:.tar.gz | inurl:.zip | inurl:.rar

4. Exposed Logs / Errors
Log Files:
site:tesla.com inurl:log | inurl:logs | filetype:log
site:tesla.com intitle:"index of" "logs"
Error Messages:
site:tesla.com intext:"fatal error" | intext:"warning" | intext:"syntax error" | intext:"stack trace"
site:tesla.com intext:"SQLSTATE" | intext:"JDBC" | intext:"PHP warning"
site:tesla.com inurl:debug

5. Emails & Contact Info
site:tesla.com intext:"@tesla.com"
site:tesla.com intext:"@tesla.com" filetype:xls OR filetype:csv
site:tesla.com intext:"email" | intext:"contact us" | intext:"support"

6. Git Folders and Env Files
Exposed .git Directories:
site:tesla.com inurl:.git/HEAD
site:tesla.com intitle:"index of /.git"
Environment Files (.env):
site:tesla.com filetype:env
site:tesla.com inurl:.env
site:tesla.com intitle:"index of" ".env"
