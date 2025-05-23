# High Value Targets

````
IdentityInfo
        | extend SensitiveUser = set_has_element(Tags, "Sensitive")
        | extend GlobalAdministrator = set_has_element(AssignedRoles, "Global Administrator")
        | extend SecurityAdministrator = set_has_element(AssignedRoles, "Security Administrator")
        | where SensitiveUser or GlobalAdministrator or SecurityAdministrator
        | summarize arg_max(Timestamp, *) by AccountObjectId, OnPremSid, CloudSid
        | project-away SensitiveUser, GlobalAdministrator, SecurityAdministrator
````
