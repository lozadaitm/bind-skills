# Enlaza cada skill de este repo a ~/.claude/skills/<nombre> con un junction.
# Uso: powershell -ExecutionPolicy Bypass -File .\install.ps1
# Si ya existe una carpeta real con el mismo nombre, se mueve a ~/.claude/skills-backup/<nombre>-<fecha>
# (fuera de skills/, para que Claude no la cargue como skill duplicada).

$ErrorActionPreference = 'Stop'

$repoSkills = Join-Path $PSScriptRoot 'skills'
$target = Join-Path $env:USERPROFILE '.claude\skills'
$backupDir = Join-Path $env:USERPROFILE '.claude\skills-backup'

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
            New-Item -ItemType Directory -Force $backupDir | Out-Null
            $backup = Join-Path $backupDir "$($skill.Name)-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Move-Item $dest $backup
            Write-Host "Respaldo: $backup"
        }
    }

    New-Item -ItemType Junction -Path $dest -Target $skill.FullName | Out-Null
    Write-Host "Enlazada: $($skill.Name) -> $($skill.FullName)"
}
