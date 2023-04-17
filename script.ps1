$response = Invoke-RestMethod -Uri "https://api.coindesk.com/v1/bpi/currentprice.json"
#$response | Get-Member
$updatedTime =  $response.time.updated
$rateUSD = $response.bpi.USD.rate_float
$rateGBP = $response.bpi.GBP.rate_float
$rateEUR = $response.bpi.EUR.rate_float

Write-Host $rateGBP

$Logfile = "C:\PS\computername.log"
function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

WriteLog 