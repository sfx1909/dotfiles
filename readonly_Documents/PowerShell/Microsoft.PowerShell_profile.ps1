function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt

Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })