function which {
    param([string]$package)
    $cmd = Get-Command $package -ErrorAction SilentlyContinue
    if ($cmd.CommandType -eq 'Alias') {
        $cmd = Get-Command $cmd.Definition -ErrorAction SilentlyContinue
    }
    return $cmd.Source ?? $cmd.Definition
}

function open {
    param(
        [string]$path
    )

    explorer.exe $path
}