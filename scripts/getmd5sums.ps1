# 获取当前目录下所有文件的详细信息
$files = Get-ChildItem -Path .

# 创建或覆盖 md5sums.txt 文件
Out-File -FilePath md5sums.txt -Force

# 遍历每个文件，计算MD5哈希值，并追加到 md5sums.txt 文件中
foreach ($file in $files) {
    if (-not $file.PSIsContainer) { # 确保不是目录
        $hash = (Get-FileHash -Path $file.FullName -Algorithm MD5).Hash
        # `n表示换行，写法很奇葩
        "$hash`n$($file.Name)" | Out-File -FilePath md5sums.txt -Append
    }
}
