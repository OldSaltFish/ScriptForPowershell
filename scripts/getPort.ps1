Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' } | 
Select-Object LocalAddress, LocalPort, State, OwningProcess | ForEach-Object {
    $process = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
    # 过滤掉特定的进程名称
    if (-not ($process.ProcessName -in @('svchost', 'System', 'vmms', 'lsass', 'wininit', 'spoolsv', 'services', 'SocketHeciServer', 'jhi_service'))) {
        [PSCustomObject]@{
            LocalAddress = $_.LocalAddress
            LocalPort    = $_.LocalPort
            State        = $_.State
            OwningProcess = $_.OwningProcess
            ProcessName  = $process.ProcessName
        }
    }
} | Format-Table -AutoSize