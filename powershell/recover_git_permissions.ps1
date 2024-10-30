# Define the ruta del repositorio
$repoPath = "ruta/al/repositorio"

# Cambia al directorio del repositorio
Set-Location $repoPath

# Filtra archivos que deberían tener permisos ejecutables (por ejemplo, scripts .sh)
$filesToFix = git ls-files --stage | ForEach-Object {
    # El formato de ls-files --stage incluye la información del modo, hash y archivo.
    # Separamos cada línea y buscamos archivos con el modo sin permisos de ejecución
    $line = $_ -split "\s+"
    $mode = $line[0]
    $file = $line[3]

    # Modo de archivo ejecutable en Unix es 100755
    # Filtramos aquellos que sean scripts .sh y que hayan perdido su bit ejecutable
    if ($file -like "*.sh" -and $mode -ne "100755") {
        $file
    }
}

# Recorrer la lista y restaurar permisos de ejecución
foreach ($file in $filesToFix) {
    Write-Host "Restaurando permisos ejecutables para: $file"
    git update-index --chmod=+x $file
}

Write-Host "Permisos ejecutables restaurados para los archivos relevantes."

