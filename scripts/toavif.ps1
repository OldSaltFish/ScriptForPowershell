# 定义图片扩展名数组
$imageExtensions = "jpg", "jpeg", "png", "gif"

# 使用foreach循环遍历每个扩展名，组合完整的通配符并获取文件
$imagesToConvert = foreach ($ext in $imageExtensions) {
    Get-ChildItem -Path . -Filter "*.$ext" -File
}

foreach ($image in $imagesToConvert) {
    # 构建新的AVIF文件名
    $avifName = $image.FullName.Substring(0, $image.FullName.Length - $image.Extension.Length) + ".avif"
    
    Write-Verbose "Preparing to convert $($image.FullName) to $($avifName)"
    
    try {
        # 执行转换命令
        magick "$($image.FullName)" "$avifName"
        Write-Host "Converted $($image.Name) to $($avifName)"
    }
    catch {
        Write-Error "Failed to convert $($image.Name): $_"
    }
}

Write-Host "All images conversion process completed. Check the log for details."