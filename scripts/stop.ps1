$ErrorActionPreference = 'Stop'
Push-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location ..

Write-Host "Stopping containers..."
docker-compose down
Pop-Location
