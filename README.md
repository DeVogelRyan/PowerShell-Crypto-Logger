# PowerShell-Crypto-Logger

This is a project to test my PowerShell. Here I retrieve information from an API and put it in a .csv file.


### How to fix error 'script.ps1 cannot be loaded because running scripts is disabled':

By default Windows disables script execution due to security reasons.
To enable this use the following command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```