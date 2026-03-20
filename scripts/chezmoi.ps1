Set-Alias cz chezmoi

function czup {
  chezmoi re-add
  chezmoi git add -- .
  chezmoi git commit -- -m "update" 2>$null
  chezmoi git push 2>$null
}

function czls { chezmoi managed }