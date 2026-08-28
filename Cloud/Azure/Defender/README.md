# Defender

- Task: Create a user who can view quarantined emails
  1. Pim (portal.azure.com) -> sign in Defender (security.microsoft.com)
  2. Go to System -> Permissions -> ms defender xdr -> Roles -> Create custom role
  3. Add name+description next -> click Security Operations -> choose custom permissions.
  4. under "Security data" choose custom permission -> tick 'Email & collaboration quarantine (manage)' + 'Security data basics (read)'
  5. Under "Raw data (Email & collaboration" choose custom permission -> 'Email & collaboration content: Quarantine Emails (read)' and click Next
  6. Click "Create assignment" -> Assingment name can be a ticket number from ServiceNow. Asignees = e.g. a user. Data and scope/Data sources = tick only 'microsoft defender for Office 365' -> Next
  7. Review and finish
