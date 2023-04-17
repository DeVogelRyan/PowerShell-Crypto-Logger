# PowerShell-Crypto-Logger

## How to fix error 'script.ps1 cannot be loaded because running scripts is disabled':

By default Windows disables script execution due to security reasons.
To enable this use the following command:

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser