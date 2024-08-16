# Función para mostrar la velocidad actual de la red
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

function Get-NetworkSpeed {
    $netStats1 = Get-NetAdapterStatistics
    Start-Sleep -Seconds 1
    $netStats2 = Get-NetAdapterStatistics

    $speedResults = @()
    foreach ($adapter in $netStats1) {
        $adapter2 = $netStats2 | Where-Object { $_.Name -eq $adapter.Name }

        if ($adapter2) {
            $bytesSentPerSec = ($adapter2.OutboundBytes - $adapter.OutboundBytes)
            $bytesReceivedPerSec = ($adapter2.InboundBytes - $adapter.InboundBytes)
            $speedResults += [pscustomobject]@{
                Adapter = $adapter.Name
                'Upload Speed (B/s)' = $bytesSentPerSec
                'Download Speed (B/s)' = $bytesReceivedPerSec
            }
        }
    }

    $speedResults | Format-Table -AutoSize
}
# Comprobar si el script se está ejecutando como administrador, si no, reiniciarlo con permisos de administrador
if (-not (Test-Admin)) {
    Restart-Admin
}
Get-NetworkSpeed
