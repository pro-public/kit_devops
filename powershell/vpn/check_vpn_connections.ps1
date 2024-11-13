# Función para obtener las conexiones VPN activas

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Función para relanzar el script como administrador
# Función para relanzar el script como administrador en una nueva ventana de PowerShell
function Restart-Admin {
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    Exit
}

function Get-VPNConnections {
    $vpnConnections = Get-VpnConnection | Where-Object { $_.ConnectionStatus -eq "Connected" }
    return $vpnConnections
}

# Función para mostrar la velocidad de la red para las conexiones VPN activas
function Get-VPNNetworkSpeed {
    $vpnConnections = Get-VPNConnections
    if ($vpnConnections.Count -eq 0) {
        Write-Output "No hay conexiones VPN activas."
        return
    }

    foreach ($vpn in $vpnConnections) {
        $adapter = Get-NetAdapter | Where-Object { $_.InterfaceDescription -like "*$($vpn.Name)*" }
        if ($null -eq $adapter) {
            Write-Output "No se encontró el adaptador para la conexión VPN: $($vpn.Name)"
            continue
        }

        $netStats1 = Get-NetAdapterStatistics -Name $adapter.Name
        Start-Sleep -Seconds 1
        $netStats2 = Get-NetAdapterStatistics -Name $adapter.Name

        $bytesSentPerSec = ($netStats2.OutboundBytes - $netStats1.OutboundBytes)
        $bytesReceivedPerSec = ($netStats2.InboundBytes - $netStats1.InboundBytes)

        [pscustomobject]@{
            VPNConnection = $vpn.Name
            Adapter = $adapter.Name
            'Upload Speed (B/s)' = $bytesSentPerSec
            'Download Speed (B/s)' = $bytesReceivedPerSec
        } | Format-Table -AutoSize
    }
}

# Ejecutar funciones
# Comprobar si el script se está ejecutando como administrador, si no, reiniciarlo con permisos de administrador
if (-not (Test-Admin)) {
    Restart-Admin
}
Get-VPNNetworkSpeed
