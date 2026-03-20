Set-Alias t psmux
function ta { psmux attach -t $args }
function tn { psmux new -s $args }
function tl { psmux ls }
function tk { psmux kill-session -t $args }

function tz {
    param([string]$name = "default")
    
    psmux attach -t $name 2>$null
    if ($LASTEXITCODE -ne 0) {
        $path = if ($name -ne "default" -and (Get-Command zoxide -ErrorAction SilentlyContinue)) { 
            zoxide query $name 2>$null 
        } else { $null }
        if (-not $path) { $path = $PWD }
        psmux new -s $name -c $path
    }
}

# zoxide 초기화
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
} else {
    Write-Warning "zoxide가 설치되어 있지 않습니다. 'scoop install zoxide'로 설치하세요."
}