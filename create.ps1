# Enable TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

try {
    if ($actionContext.CorrelationConfiguration.Enabled) {
        $correlationField = $actionContext.CorrelationConfiguration.AccountField
        $correlationValue = $actionContext.CorrelationConfiguration.PersonFieldValue

        if ([string]::IsNullOrEmpty($($correlationField))) {
            throw 'Correlation is enabled but not configured correctly'
        }
        if ([string]::IsNullOrEmpty($($correlationValue))) {
            throw 'Correlation is enabled but [accountFieldValue] is empty. Please make sure it is correctly mapped'
        }

        # === [AI_SECTION: FIND_ACCOUNT] ===
        # INSERT CODE HERE to get account from target system based on correlation field/value.
        # Example: $correlatedAccount = Invoke-RestMethod -Uri ...
        # The result should be the found account object or null.
        # === [END_SECTION] ===
    }

    if ($correlatedAccount.Count -eq 0) {
        $action = 'CreateAccount'
    } elseif ($correlatedAccount.Count -eq 1) {
        $action = 'CorrelateAccount'
    } elseif ($correlatedAccount.Count -gt 1) {
        throw "Multiple accounts found for person where $correlationField is: [$correlationValue]"
    }

    # Process
    switch ($action) {
        'CreateAccount' {
            Write-Information 'Creating and correlating account'

            # === [AI_SECTION: CREATE_ACCOUNT] ===
            # INSERT CODE HERE to create a new account in target system.
            # Set $createdAccount to the created object.
            # === [END_SECTION] ===

            $outputContext.Data = $createdAccount
            $outputContext.AccountReference = $createdAccount.Id # May differ per system
            $auditLogMessage = "Create account was successful. AccountReference is: [$($outputContext.AccountReference)]"
            break
        }

        'CorrelateAccount' {
            Write-Information 'Correlating account'

            # === [AI_SECTION: CORRELATE_ACCOUNT] ===
            # INSERT CODE HERE if special handling is needed for correlation.
            # Usually, you just reuse $correlatedAccount.
            # === [END_SECTION] ===

            $outputContext.Data = $correlatedAccount
            $outputContext.AccountReference = $correlatedAccount.Id
            $outputContext.AccountCorrelated = $true
            $auditLogMessage = "Correlated account: [$($outputContext.AccountReference)] on field: [$($correlationField)] with value: [$($correlationValue)]"
            break
        }
    }

    $outputContext.success = $true
    $outputContext.AuditLogs.Add([PSCustomObject]@{
        Action  = $action
        Message = $auditLogMessage
        IsError = $false
    })
}
catch {
    $outputContext.success = $false
    $ex = $PSItem
    $auditMessage = "Could not create or correlate {connectorName} account. Error: $($ex.Exception.Message)"
    Write-Warning "Error at Line '$($ex.InvocationInfo.ScriptLineNumber)': $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
    $outputContext.AuditLogs.Add([PSCustomObject]@{
        Message = $auditMessage
        IsError = $true
    })
}
