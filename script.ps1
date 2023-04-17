
$Logfile = "C:\PS\computername.log"
function WriteLog {
    param(
        # Forcing the need for this parameter.
        [Parameter(Position = 0, mandatory = $true)]
        [System.Object] $BTCData)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $LogMessage = $Stamp + " " + $BTCData.rateUSD
    Add-content $LogFile -value $LogMessage

    Write-Host "object:" $LogMessage
}

function RequestAPI {
    Param ([string]$url)
    $response = Invoke-RestMethod -Uri $url
    #pass properties to object
    $data = [PSCustomObject]@{
        updatedTime = $response.time.updated
        rateUSD     = $response.bpi.USD.rate_float
        rateGBP     = $response.bpi.GBP.rate_float
        rateEUR     = $response.bpi.EUR.rate_float
    }

    WriteLog $data
}

RequestAPI "https://api.coindesk.com/v1/bpi/currentprice.json"