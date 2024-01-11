#  Conclusion: the OIDC metadata endpoint in each cloud will return domain metadata of its own cloud instance prior to other cloud instances.
 
# Confirm if a domain is registered in Mooncake:
# Access Mooncake endpoint https://login.partner.microsoftonline.cn/<domain>/v2.0/.well-known/openid-configuration, replace <domain> with the true custom domain name.
#       1. If you see token endpoint contains https://login.partner.microsoftonline.cn/<domain>/oauth2/v2.0/token, then the domain is registered in Mooncake, but also could be registered in public Azure.
#       2. If you see token endpoint contains https://login.microsoftonline.com/<domain>/oauth2/v2.0/token, then the domain is only registered in public Azure.
 
# Confirm if a domain is registered in public Azure:
# Access public Azure endpoint https://login.microsoftonline.com/<domain>/v2.0/.well-known/openid-configuration, replace <domain> with the true custom domain name.
#       1. If you see token endpoint contains https://login.partner.microsoftonline.cn/<domain>/oauth2/v2.0/token, then the domain is only registered in Mooncake.
# If you see token endpoint contains https://login.microsoftonline.com/<domain>/oauth2/v2.0/token, then the domain is registered in public Azure, but also could be registered in Mooncake.
Param(
  [Parameter(Mandatory = $True)][string]$domain
)
 
Try {
    $meta_mc = ((curl https://login.partner.microsoftonline.cn/$domain/v2.0/.well-known/openid-configuration  -UseBasicParsing).Content | ConvertFrom-Json )
    $meta_pub = ((curl https://login.microsoftonline.com/$domain/v2.0/.well-known/openid-configuration  -UseBasicParsing).Content | ConvertFrom-Json )
 
    $meta_mc.token_endpoint
    if ( $meta_mc.token_endpoint -match "microsoftonline.cn" ) {
        Write-Host "$domain is registered in Mooncake" -For Green
    }
    elseif ( $meta_mc.token_endpoint -match "microsoftonline.com" ) {
        Write-Host "$domain is registered in Public only" -Fore Green
    }
 
 
    $meta_pub.token_endpoint
    if ( $meta_pub.token_endpoint -match "microsoftonline.cn" ) {
        Write-Host "$domain is registered in Mooncake only" -Fore Green
    }
    elseif ( $meta_pub.token_endpoint -match "microsoftonline.com" ) {
        Write-Host "$domain is registered in Public" -Fore Green
    }
}
Catch {
    Write-Host "An Error occured:" -ForegroundColor Red
    Write-Host  $_ -ForegroundColor Yellow
}