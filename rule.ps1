<#
Este script crea una regla en el firewall de Windows que bloquea la coneción 
a los servidores de Blizzard en Brasil "SAE-1", haciendo que el cliente se 
conecte a los servidores alojados en Estados Unidos.
#>

$Hosts =	
"15.228.0.0/16",
"18.228.0.0/16", 
"18.229.0.0/16",
"18.230.0.0/16",
"18.231.0.0/16", 
"52.67.0.0/16", 
"52.94.0.0/16",
"52.95.0.0/16",
"52.207.0.0/16", 
"54.94.0.0/16", 
"54.207.0.0/16", 
"54.232.0.0/16", 
"54.233.0.0/16", 
"177.71.0.0/16"

function CreateRule {
	$GamePath = Read-Host "Indique la ruta donde está instalado Overwatch [ej. c:\Overwatch\_retail_\Overwatch.exe]"
	New-NetFirewallRule -DisplayName "Overwatch" `
		-Direction Outbound `
		-Program $GamePath `
		-LocalPort Any `
		-Protocol Any `
		-Action Block `
		-RemoteAddress $Hosts
}

function RemoveRule {
	Remove-NetFirewallRule -DisplayName "Overwatch"
}


if ($(Get-NetFirewallRule -DisplayName "Overwatch" -ErrorAction SilentlyContinue)) {
	RemoveRule
	CreateRule	
}
else {
	CreateRule
}

Clear-Host
Write-Host "La regla fue creada satisfactoriamente."