function Test-NetSpeed {
    # 国内稳定的测速文件（小文件，确保快速完成）
    $testUrls = @(
        # "http://down.sandai.net/thunder11/XunLeiWebSetup11.3.13.1912.exe"  # 迅雷下载节点（1MB+）
        "https://down.pc.yyb.qq.com/pcyyb/packing/6dac231c763750e6d04d7190f66e7964/pcyyb_com.shuqi.controller_2100100017_installer.exe"
        "http://download.microsoft.com/download/8/7/5/875B1A0E-DF4A-4485-A4CF-2DB8B3D6A1BB/Windows10Upgrade9252.exe"  # 微软下载（小文件）
    )

    $tempFile = "$env:TEMP\netspeed.tmp"
    $maxRetries = 2  # 每个地址最多尝试次数

    foreach ($url in $testUrls) {
        $retryCount = 0
        while ($retryCount -lt $maxRetries) {
            try {
                Write-Host "正在测试: $url" -ForegroundColor Cyan
                $startTime = (Get-Date)  # 修复时间计算错误

                # 使用 WebClient 下载（兼容性更好）
                $webClient = New-Object System.Net.WebClient
                $webClient.DownloadFile($url, $tempFile)

                $timeTaken = ((Get-Date) - $startTime).TotalSeconds
                $fileSizeMB = (Get-Item $tempFile).Length / 1MB
                $speedMBps = [Math]::Round($fileSizeMB / $timeTaken, 2)

                Write-Host "下载速度: $speedMBps MB/s" -ForegroundColor Green
                return  # 成功即退出
            } catch {
                $retryCount++
                Write-Host "尝试 $retryCount/$maxRetries 失败: $($_.Exception.Message)" -ForegroundColor Yellow
                Start-Sleep -Seconds 1  # 延迟1秒后重试
            } finally {
                if (Test-Path $tempFile) { Remove-Item $tempFile -Force -ErrorAction SilentlyContinue }
                if ($webClient) { $webClient.Dispose() }  # 释放资源
            }
        }
    }
    Write-Host "所有测速节点均失败，请检查网络连接或代理设置！" -ForegroundColor Red
}

# 执行测速
Test-NetSpeed