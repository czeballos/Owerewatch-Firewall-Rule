<#
Este script crea reglas en el firewall de Windows que bloquea la coneción 
a los servidores de Blizzard en Brasil, haciendo que el cliente se 
conecte a los servidores alojados en Estados Unidos.
#>

$Hosts =	
"34.94.0.0/16",
"34.95.0.0/16",
"34.151.0.0/16",
"35.95.0.0/16",
"35.151.0.0/16",
"35.198.0.0/16",
"35.199.0.0/16",
"35.235.0.0/16",
"35.247.0.0/16"

function CreateRule {
	$GamePath = Read-Host "Indique la ruta donde está instalado Overwatch [ej. c:\Overwatch\_retail_\Overwatch.exe]"
	$GamePath = Read-Host "Indique la ruta donde está instalado Battlenet [ej. c:\ProgramFiles (x86)\Battle.net\Battle.net.exe"

	New-NetFirewallRule -DisplayName "Overwatch2" `
		-Direction Outbound `
		-Program $GamePath `
		-LocalPort Any `
		-Protocol Any `
		-Action Block `
		-RemoteAddress $Hosts

	New-NetFirewallRule -DisplayName "Battlenet" `
		-Direction Outbound `
		-Program $Battlenet `
		-LocalPort Any `
		-Protocol Any `
		-Action Block `
		-RemoteAddress $Hosts
}

function RemoveRule {
	Remove-NetFirewallRule -DisplayName "Overwatch2"
	Remove-NetFirewallRule -DisplayName "Battlenet"
}


if ($(Get-NetFirewallRule -DisplayName "Overwatch2" -ErrorAction SilentlyContinue)) {
	RemoveRule
	CreateRule	
}
else {
	CreateRule
}

Clear-Host
Write-Host "Las reglas fueron creadas satisfactoriamente."