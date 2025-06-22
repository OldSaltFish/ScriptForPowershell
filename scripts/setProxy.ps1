# 获取系统代理设置
$proxySettings = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
$proxyServer = $proxySettings.ProxyServer
$proxyEnabled = $proxySettings.ProxyEnable

# 设置代理
if ($proxyEnabled -eq 1) {
    $proxyUrl = "http://$proxyServer"
    [System.Environment]::SetEnvironmentVariable('HTTP_PROXY', $proxyUrl, 'Process')
    [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY', $proxyUrl, 'Process')
    Write-Host "已设置代理: $proxyUrl"
} else {
    Write-Host "系统代理未启用"
}