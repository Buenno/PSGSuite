function Get-LicenseSkus {
    ConvertFrom-Json '{"1010010001":{"displayName":"Cloud Identity Premium","product":"101001"},"1010020020":{"displayName":"Google Workspace Enterprise Plus","product":"Google-Apps"},"1010020025":{"displayName":"Google Workspace Business Plus","product":"Google-Apps"},"1010020026":{"displayName":"Google Workspace Enterprise Standard","product":"Google-Apps"},"1010020027":{"displayName":"Google Workspace Business Starter","product":"Google-Apps"},"1010020028":{"displayName":"Google Workspace Business Standard","product":"Google-Apps"},"1010020029":{"displayName":"Google Workspace Enterprise Starter","product":"Google-Apps"},"1010020030":{"displayName":"Google Workspace Frontline Starter","product":"Google-Apps"},"1010020031":{"displayName":"Google Workspace Frontline Standard","product":"Google-Apps"},"1010060001":{"displayName":"Google Workspace Essentials","product":"Google-Apps"},"1010060003":{"displayName":"Google Workspace Enterprise Essentials","product":"Google-Apps"},"1010060005":{"displayName":"Google Workspace Essentials Plus","product":"Google-Apps"},"1010310002":{"displayName":"Google Workspace for Education Plus - Legacy","product":"101031"},"1010310003":{"displayName":"Google Workspace for Education Plus - Legacy (Student)","product":"101031"},"1010310005":{"displayName":"Google Workspace for Education Standard","product":"101031"},"1010310006":{"displayName":"Google Workspace for Education Standard (Staff)","product":"101031"},"1010310007":{"displayName":"Google Workspace for Education Standard (Extra Student)","product":"101031"},"1010310008":{"displayName":"Google Workspace for Education Plus","product":"101031"},"1010310009":{"displayName":"Google Workspace for Education Plus (Staff)","product":"101031"},"1010310010":{"displayName":"Google Workspace for Education Plus (Extra Student)","product":"101031"},"1010330002":{"displayName":"Google Voice Premier","product":"101033"},"1010330003":{"displayName":"Google Voice Starter","product":"101033"},"1010330004":{"displayName":"Google Voice Standard","product":"101033"},"1010340001":{"displayName":"Google Workspace Enterprise Plus - Archived User","product":"101034"},"1010340002":{"displayName":"G Suite Business - Archived User","product":"101034"},"1010340003":{"displayName":"Google Workspace Business Plus - Archived User","product":"101034"},"1010340004":{"displayName":"Google Workspace Enterprise Standard - Archived User","product":"101034"},"1010340005":{"displayName":"Google Workspace Business Starter - Archived User","product":"101034"},"1010340006":{"displayName":"Google Workspace Business Standard - Archived User","product":"101034"},"1010370001":{"displayName":"Google Workspace for Education: Teaching and Learning Upgrade","product":"101037"},"1010380001":{"displayName":"AppSheet Core","product":"101038"},"1010380002":{"displayName":"AppSheet Enterprise Standard","product":"101038"},"1010380003":{"displayName":"AppSheet Enterprise Standard","product":"101038"},"Google-Apps-Unlimited":{"displayName":"G Suite Business","product":"Google-Apps"},"Google-Apps-For-Business":{"displayName":"G Suite Basic","product":"Google-Apps"},"Google-Apps-Lite":{"displayName":"G Suite Lite","product":"Google-Apps"},"Google-Apps-For-Postini":{"displayName":"Google Apps Message Security","product":"Google-Apps"},"Google-Apps-For-Education":{"displayName":"Google Workspace for Education Fundamentals","product":"Google-Apps"},"Google-Vault":{"displayName":"Google Vault","product":"Google-Vault"},"Google-Vault-Former-Employee":{"displayName":"Google Vault Former Employee","product":"Google-Vault"}}'
}

function Get-LicenseProducts {
    ConvertFrom-Json '{"101001":"Cloud Identity","101005":"Cloud Identity Premium","101031":"Google Workspace for Education","101033":"Google Voice","101034":"Google Workspace Archived User","101037":"Google Workspace for Education","101038":"AppSheet","Google-Apps":"Google Workspace","Google-Vault":"Google Vault"}'
}

function Get-LicenseProductHash {
    Param (
        [Parameter(Position = 0)]
        [String]
        $Key
    )
    $_result = @{'Cloud-Identity' = '101001'}
    $_full = Get-LicenseProducts
    $_products = $_full.PSObject.Properties.Name | Sort-Object -Unique
    foreach ($_id in $_products) {
        $_friendlyname = $_full.$_id -replace '\W+','-'
        $_result[$_id] = $_id
        $_result[$_friendlyname] = $_id
    }
    if ($Key) {
        $_result[$Key]
    }
    else {
        $_result
    }
}

function Get-LicenseSkuHash {
    Param (
        [Parameter(Position = 0)]
        [String]
        $Key
    )
    $_result = @{}
    $_full = Get-LicenseSkus
    $_licenses = $_full.PSObject.Properties.Name | Sort-Object -Unique
    foreach ($_sku in $_licenses) {
        $_displayName = $_full.$_sku.displayName -replace '\W+','-'
        $_result[$_displayName] = $_sku
        foreach ($_alias in $_full.$_sku.aliases) {
            $_result[$_alias] = $_sku
        }
    }
    if ($Key) {
        $_result[$Key]
    }
    else {
        $_result
    }
}

function Get-LicenseSkuToProductHash {
    Param (
        [Parameter(Position = 0)]
        [String]
        $Key
    )
    $_result = @{}
    $_full = Get-LicenseSkus
    $_licenses = $_full.PSObject.Properties.Name | Sort-Object -Unique
    foreach ($_sku in $_licenses) {
        $_displayName = $_full.$_sku.displayName -replace '\W+','-'
        $_result[$_sku] = $_full.$_sku.product
        $_result[$_displayName] = $_full.$_sku.product
        foreach ($_alias in $_full.$_sku.aliases) {
            $_result[$_alias] = $_full.$_sku.product
        }
    }
    if ($Key) {
        $_result[$Key]
    }
    else {
        $_result
    }
}

function Get-LicenseSkuFromDisplayName  {
    Param (
        [Parameter(Position = 0)]
        [String]
        $Key
    )
    $_result = @{}
    $_full = Get-LicenseSkus
    $_licenses = $_full.PSObject.Properties.Name | Sort-Object -Unique
    foreach ($_sku in $_licenses) {
        $_displayName = $_full.$_sku.displayName -replace '\W+','-'
        $_result[$_displayName] = $_sku
    }
    if ($Key) {
        $_result[$Key]
    }
    else {
        $_result
    }
}

function Get-LicenseProductFromDisplayName {
    Param (
        [Parameter(Position = 0)]
        [String]
        $Key
    )
    $_result = @{'Cloud-Identity' = '101001'}
    $_full = Get-LicenseProducts
    $_products = $_full.PSObject.Properties.Name | Sort-Object -Unique
    foreach ($_id in $_products) {
        $_friendlyname = $_full.$_id -replace '\W+','-'
        $_result[$_friendlyname] = $_id
    }
    if ($Key) {
        $_result[$Key]
    }
    else {
        $_result
    }
}
