# Función para comprobar si se están descargando actualizaciones de Windows
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Función para relanzar el script como administrador
function Restart-Admin {
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    Exit
}

function Check-WindowsUpdates {
    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
    $SearchResult = $UpdateSearcher.Search("IsInstalled=0 AND Type='Software'")

    if ($SearchResult.Updates.Count -eq 0) {
        Write-Output "No hay actualizaciones pendientes."
    } else {
        foreach ($Update in $SearchResult.Updates) {
            if ($Update.IsDownloaded -eq $false) {
                Write-Output "Se están descargando actualizaciones:"
                Write-Output " - $($Update.Title)"
            } else {
                Write-Output "Actualización descargada: $($Update.Title)"
            }
        }
    }
}

# Ejecutar funciones
# Comprobar si el script se está ejecutando como administrador, si no, reiniciarlo con permisos de administrador
if (-not (Test-Admin)) {
    Restart-Admin
}
Check-WindowsUpdates
