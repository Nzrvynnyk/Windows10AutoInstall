param(
    $mail
)
$mail = $env:computername | ForEach-Object { $_.Insert(1,".") -replace ("-", "@astoundcommerce.com") -replace ("NB", "")}


if ([string]::IsNullOrEmpty($mail)) {
    Write-Output "Mail must be defined. Use -mail <value> to pass it."
    EXIT 1
}
else {
$file = 'Vanta.msi'
$link = "https://app.vanta.com/osquery/download/windows"
$soft_name = 'vanta.msi'
$find = Get-WmiObject -Class Win32_Product -Filter "Name = `'$soft_name`'"
}
if ($find -eq $null) {

    $tmp = "C:\ProgramData\$file"
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($link, $tmp)
}
$arguments = "/i $tmp /qn VANTA_KEY=""cv9uv6y2gh491hydph0fh59qxe5u634fmj5t11qcwtpdnxh3qykg"" VANTA_OWNER_EMAIl=$mail" 

Start-Process msiexec.exe -ArgumentList $arguments -Wait
Start-Sleep -s 10
Remove-Item $tmp
$command = "C:\ProgramData\Vanta\vanta-cli.exe check-registration"
Invoke-Expression -Command $command
Write-Output $command
