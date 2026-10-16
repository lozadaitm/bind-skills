# Enlaza cada skill de este repo a ~/.claude/skills/<nombre> con un junction.
# Uso: powershell -ExecutionPolicy Bypass -File .\install.ps1
# Si ya existe una carpeta real con el mismo nombre, se renombra a <nombre>.bak-<fecha> (no se borra).

$ErrorActionPreference = 'Stop'

$repoSkills = Join-Path $PSScriptRoot 'skills'
$target = Join-Path $env:USERPROFILE '.claude\skills'

if (-not (Test-Path $target)) {
    New-Item -ItemType Directory -Force $target | Out-Null
}

foreach ($skill in Get-ChildItem -Directory $repoSkills) {
    $dest = Join-Path $target $skill.Name

    if (Test-Path $dest) {
        $item = Get-Item $dest -Force
        if ($item.LinkType) {
            # Enlace previo: se reemplaza.
            $item.Delete()
        } else {
            $backup = "$dest.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Rename-Item $dest $backup
            Write-Host "Respaldo: $backup"
        }
    }

    New-Item -ItemType Junction -Path $dest -Target $skill.FullName | Out-Null
    Write-Host "Enlazada: $($skill.Name) -> $($skill.FullName)"
}
