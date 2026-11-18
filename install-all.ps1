param(
    [ValidateSet("during", "after", "ask", "skip")]
    [string]$AntislopMode = "skip"
)

$ErrorActionPreference = "Stop"

$pluginsDir = Join-Path $HOME ".gemini\config\plugins"
$tmpDir = Join-Path $env:TEMP "agent-skills-bootstrap"

if (Test-Path $tmpDir) { Remove-Item -Recurse -Force $tmpDir }
New-Item -ItemType Directory -Path $tmpDir, $pluginsDir -Force | Out-Null

function Install-SkillPack {
    param(
        [string]$RepoUrl,
        [string]$PluginName,
        [string]$DisplayName,
        [string]$Description,
        [string[]]$SourceSubPaths = @("skills")
    )

    Write-Host "==> Installing $PluginName from $RepoUrl ..." -ForegroundColor Cyan
    $clone = Join-Path $tmpDir $PluginName
    git clone --depth 1 $RepoUrl $clone

    $dest = Join-Path $pluginsDir $PluginName
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    New-Item -ItemType Directory -Path (Join-Path $dest "skills") -Force | Out-Null

    $manifest = @{
        name        = $PluginName
        displayName = $DisplayName
        version     = "1.0.0"
        description = $Description
        repository  = $RepoUrl
    } | ConvertTo-Json -Depth 4
    Set-Content -Path (Join-Path $dest "plugin.json") -Value $manifest -Encoding utf8

    foreach ($sub in $SourceSubPaths) {
        $srcPath = Join-Path $clone $sub
        if (Test-Path $srcPath) {
            Get-ChildItem -Path $srcPath -Directory | ForEach-Object {
                Copy-Item -Path $_.FullName -Destination (Join-Path $dest "skills\$($_.Name)") -Recurse -Force
            }
        }
    }

    $readme = Join-Path $clone "README.md"
    if (Test-Path $readme) {
        Copy-Item -Path $readme -Destination (Join-Path $dest "README.md") -Force
    }
}

# 1. Install custom autopilot-workflows plugin from this repo
Write-Host "==> Installing autopilot-workflows ..." -ForegroundColor Cyan
$autopilotDest = Join-Path $pluginsDir "autopilot-workflows"
if (Test-Path $autopilotDest) { Remove-Item -Recurse -Force $autopilotDest }
Copy-Item -Path (Join-Path $PSScriptRoot "autopilot-workflows") -Destination $autopilotDest -Recurse -Force

# 2. Install mattpocock-skills
Install-SkillPack `
    -RepoUrl "https://github.com/farfarfun-skills/mattpocock--skills.git" `
    -PluginName "mattpocock-skills" `
    -DisplayName "Matt Pocock Skills" `
    -Description "Matt Pocock's agent skills for engineering: setup, grilling, spec/ticket flows, TDD, code review, domain modelling, and more." `
    -SourceSubPaths @("skills\engineering", "skills\productivity")

# 3. Install vercel-agent-skills
Install-SkillPack `
    -RepoUrl "https://github.com/vercel-labs/agent-skills.git" `
    -PluginName "vercel-agent-skills" `
    -DisplayName "Vercel Agent Skills" `
    -Description "Vercel Engineering agent skills for React/Next.js performance, composition patterns, view transitions, web design/accessibility audits, writing guidelines, and Vercel deployment." `
    -SourceSubPaths @("skills")

# 4. Install anthropics-skills
Install-SkillPack `
    -RepoUrl "https://github.com/anthropics/skills.git" `
    -PluginName "anthropics-skills" `
    -DisplayName "Anthropic Skills" `
    -Description "Anthropic's collection of agent skills covering intentional frontend design, document processing (docx, pdf, pptx, xlsx), Playwright webapp testing, MCP server building, and skill creation." `
    -SourceSubPaths @("skills")

# 5. Install antislop (skills + always-on rules/AGENTS.md)
Write-Host "==> Installing antislop ..." -ForegroundColor Cyan
$antiClone = Join-Path $tmpDir "anti-slop"
git clone --depth 1 "https://github.com/miqdadbadjuber/anti-slop.git" $antiClone
$antiDest = Join-Path $pluginsDir "antislop"
if (Test-Path $antiDest) { Remove-Item -Recurse -Force $antiDest }
New-Item -ItemType Directory -Path (Join-Path $antiDest "skills"), (Join-Path $antiDest "rules") -Force | Out-Null

$antiManifest = @{
    name        = "antislop"
    displayName = "antislop"
    version     = "3.2.30"
    description = "Anti Slop: Rules for AI Coding Agents. Stops generic AI slop in generated UI, copy, accessibility, mobile layout, and code comments."
    homepage    = "https://antislop.ai.id"
    repository  = "https://github.com/miqdadbadjuber/anti-slop"
} | ConvertTo-Json -Depth 4
Set-Content -Path (Join-Path $antiDest "plugin.json") -Value $antiManifest -Encoding utf8

Get-ChildItem -Path (Join-Path $antiClone "skills") -Directory | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination (Join-Path $antiDest "skills\$($_.Name)") -Recurse -Force
}
Copy-Item -Path (Join-Path $antiClone "rules\antislop.md") -Destination (Join-Path $antiDest "rules\AGENTS.md") -Force
foreach ($doc in @("antislop.md", "README.md", "GUIDE.md")) {
    $docPath = Join-Path $antiClone $doc
    if (Test-Path $docPath) {
        Copy-Item -Path $docPath -Destination (Join-Path $antiDest $doc) -Force
    }
}

if ($AntislopMode -ne "skip") {
    $appDataRoot = if ($env:APPDATA) { $env:APPDATA } else { Join-Path $HOME ".config" }
    $antiSettingsDir = Join-Path $appDataRoot "antislop"
    New-Item -ItemType Directory -Path $antiSettingsDir -Force | Out-Null
    @{ mode = $AntislopMode } | ConvertTo-Json | Set-Content -Path (Join-Path $antiSettingsDir "settings.json") -Encoding utf8
    Write-Host "==> Configured antislop default mode: $AntislopMode" -ForegroundColor Green
}

# Clean up temp clone directory
Remove-Item -Recurse -Force $tmpDir

Write-Host ""
Write-Host "Installation complete! Installed plugins in ${pluginsDir}:" -ForegroundColor Green
Get-ChildItem $pluginsDir -Directory | ForEach-Object {
    $skillCount = (Get-ChildItem (Join-Path $_.FullName "skills") -Directory -ErrorAction SilentlyContinue).Count
    Write-Host "  - $($_.Name) ($skillCount skills)"
}
Write-Host ""
Write-Host "Note: Install 'Superpowers' (obra/superpowers) via the Antigravity Agent Marketplace." -ForegroundColor Yellow
