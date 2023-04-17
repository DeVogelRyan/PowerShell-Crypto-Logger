$response = Invoke-RestMethod -Uri "https://api.coindesk.com/v1/bpi/currentprice.json"
$response | Get-Member
$updatedTime =  $response.time.updated
$rate = $response.bpi.EUR.rate_float

Write-Host $rate