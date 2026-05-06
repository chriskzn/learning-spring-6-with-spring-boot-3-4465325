$ErrorActionPreference = 'Stop'
Push-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location ..

Write-Host "Starting Postgres and Adminer..."
docker-compose up -d postgres adminer

Write-Host "Waiting for Postgres to accept connections..."
while (-not (docker logs lil_postgres 2>&1 | Select-String "database system is ready to accept connections")) {
    Start-Sleep -Seconds 1
}
Write-Host "Postgres is ready."
Write-Host "Postgres is ready."

Write-Host "Building and starting landon-hotel container..."
docker-compose up -d --build landon-hotel

Write-Host "Services status:"
docker-compose ps
Pop-Location
