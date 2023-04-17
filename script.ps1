function WriteLog {
    param(
        # Forcing the need for this parameter. As well as making sure it's an object.
        [Parameter(Position = 0, mandatory = $true)]
        [System.Object] $BTCData)
    $fileName = Read-Host -Prompt 'Give me the filename pls. No file extension is needed'
    $filePath = "C:\PS\{0}.csv" -f $fileName
    $items = '"{0}", "{1}", "{2}", "{3}"' -f $BTCData.updatedTime, $BTCData.rateUSD, $BTCData.rateGBP, $BTCData.rateEUR
    if (-Not (Test-Path $filePath)) {
        Add-content $filePath -value "UpdatedAt, USDRate, BGPRate, EURRate"
    }
    Add-content $filePath -value $items

    Write-host "The file is being written at: " $filePath
}

function RequestAPI {
    # Retrieve URL from .env file
    get-content .env | foreach {
        # Split the name of the variable and the value. Outcome: name=URL, value="http//url..."
        $name, $value = $_.split('=')
        Write-Host $value
        # API request
        $response = Invoke-RestMethod -Uri $value
        # Pass properties to object
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
