function WriteLog {
    param(
        # Forcing the need for this parameter.
        [Parameter(Position = 0, mandatory = $true)]
        [System.Object] $BTCData)
    $Logfile = "C:\PS\computername.csv"
    $LogMessage = '"{0}", "{1}", "{2}", "{3}"' -f $BTCData.updatedTime, $BTCData.rateUSD, $BTCData.rateGBP, $BTCData.rateEUR
    if (-Not (Test-Path $Logfile)) {
        Add-content $LogFile -value "UpdatedAt, USDRate, BGPRate, EURRate"
    }
    Add-content $LogFile -value $LogMessage
}

function RequestAPI {
    # retrieve URL from .env file
    get-content .env | foreach {
        $name, $value = $_.split('=')
        Write-Host $value
        $response = Invoke-RestMethod -Uri $value
        #pass properties to object
        $data = [PSCustomObject]@{
            updatedTime = $response.time.updated
            rateUSD     = $response.bpi.USD.rate_float
            rateGBP     = $response.bpi.GBP.rate_float
            rateEUR     = $response.bpi.EUR.rate_float
        }

        WriteLog $data
    }
}

RequestAPI