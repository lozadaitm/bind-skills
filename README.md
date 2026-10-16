# bind-skills

Skills de Claude Code para el flujo de trabajo de Bind.

## Skills

| Skill | Uso | Qué hace |
|---|---|---|
| [`tarea`](skills/tarea/SKILL.md) | `/tarea <código \| ID \| URL>` | Trabaja una tarea de ClickUp de punta a punta: lee tarea y comentarios, plan con aprobación, rama por grupo, commits `[código]`, PR de grupo en borrador, relevo en ClickUp y lista "Qué verificar". Si el proyecto tiene su propio `.claude/commands/tarea.md`, usa ese. |

Requiere el conector de ClickUp activo en Claude y `gh` autenticado para los PR.

## Instalación (Windows)

```powershell
git clone https://github.com/lozadaitm/bind-skills.git
cd bind-skills
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

`install.ps1` crea un junction por skill en `%USERPROFILE%\.claude\skills\`. Así el repo es la fuente: editas aquí y `git pull` actualiza las skills. Si ya había una carpeta con el mismo nombre, se respalda como `<nombre>.bak-<fecha>`.

## Agregar una skill

1. Crear `skills/<nombre>/SKILL.md`.
2. Correr `install.ps1` de nuevo.
3. Commit y push.
