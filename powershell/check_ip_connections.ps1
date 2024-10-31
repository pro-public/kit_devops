# Verifica si el script se está ejecutando como administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Si no es administrador, reinicia el script como administrador
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Define las IPs que deseas verificar
$ips = @("180.101.50.188", "203.119.25.1", "202.112.0.44")  # Reemplaza con las IPs que necesites

# Bucle infinito para verificar conexiones cada 30 segundos
while ($true) {
    # Obtiene las conexiones de red activas
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' }

    # Filtra las conexiones que coinciden con las IPs especificadas
    $filteredConnections = $connections | Where-Object { $ips -contains $_.RemoteAddress.IPAddressToString }

    # Si hay conexiones filtradas, muestra el proceso asociado
    if ($filteredConnections) {
        foreach ($connection in $filteredConnections) {
            $process = Get-Process -Id $connection.OwningProcess
            Write-Output "El programa '$($process.Name)' (ID: $($process.Id)) está conectado a la IP $($connection.RemoteAddress)"
        }
    } else {
        Write-Output "No se encontraron conexiones a las IPs especificadas."
    }

    # Espera 30 segundos antes de la siguiente verificación
    Start-Sleep -Seconds 30
}

# Nota: Presiona Ctrl+C para salir del script