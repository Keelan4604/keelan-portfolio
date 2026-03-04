param(
  [Parameter(Mandatory=$true)]
  [ValidateSet('on','off','state')]
  [string]$Action,

  [Parameter(Mandatory=$true)]
  [string]$EntityId,

  [string]$HaUrl = 'https://keelanodoherty.org',
  [string]$TokenFile = 'C:\Users\Keela\.openclaw\secrets\ha_token.txt'
)

$ErrorActionPreference = 'Stop'
if (!(Test-Path $TokenFile)) { throw "Token file not found: $TokenFile" }
$token = (Get-Content -Raw $TokenFile).Trim()
$auth = @{ Authorization = "Bearer $token" }

switch ($Action) {
  'state' {
    $s = Invoke-RestMethod -Uri "$HaUrl/api/states/$EntityId" -Headers $auth -Method Get
    [pscustomobject]@{ entity_id = $EntityId; state = $s.state; friendly_name = $s.attributes.friendly_name } | ConvertTo-Json -Compress
    break
  }
  'on' {
    $headers = @{ Authorization = "Bearer $token"; 'Content-Type' = 'application/json' }
    $body = @{ entity_id = $EntityId } | ConvertTo-Json
    Invoke-RestMethod -Uri "$HaUrl/api/services/light/turn_on" -Headers $headers -Method Post -Body $body | Out-Null
    $s = Invoke-RestMethod -Uri "$HaUrl/api/states/$EntityId" -Headers $auth -Method Get
    [pscustomobject]@{ entity_id = $EntityId; state = $s.state } | ConvertTo-Json -Compress
    break
  }
  'off' {
    $headers = @{ Authorization = "Bearer $token"; 'Content-Type' = 'application/json' }
    $body = @{ entity_id = $EntityId } | ConvertTo-Json
    Invoke-RestMethod -Uri "$HaUrl/api/services/light/turn_off" -Headers $headers -Method Post -Body $body | Out-Null
    $s = Invoke-RestMethod -Uri "$HaUrl/api/states/$EntityId" -Headers $auth -Method Get
    [pscustomobject]@{ entity_id = $EntityId; state = $s.state } | ConvertTo-Json -Compress
    break
  }
}
