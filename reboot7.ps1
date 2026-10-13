# 管理者権限チェック
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Please run this script as Administrator."
    exit
}

# 1. 午前 5:00 まで待機
$now = Get-Date
$updateTime = Get-Date -Hour 5 -Minute 0 -Second 0
if ($now -ge $updateTime) {
    $updateTime = $updateTime.AddDays(1)
}

$waitForUpdate = [math]::Round(($updateTime - $now).TotalSeconds)
Write-Host "Waiting until 05:00 AM to start Windows Update... ($waitForUpdate seconds)" -ForegroundColor Yellow
Start-Sleep -Seconds $waitForUpdate

# 2. 午前 5:00 - Windows Update実行 ＆ 終了後に自動再起動
Write-Host "Starting Windows Update and Auto Reboot..." -ForegroundColor Green
Get-WindowsUpdate -AcceptAll -Install -AutoReboot