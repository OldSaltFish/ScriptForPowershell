
if ($args.Length -ne 1) {
    Write-Error "必须指定目标参数targetDir，请检查路径中是否有空格，有空格需要对路径整体加引号！"
    exit 1
}

$sourceDir = pwd
$targetDir = $args[0]


if (-not (Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir
}


$files = Get-ChildItem -Path $sourceDir -File


foreach ($file in $files) {
    $sourcePath = $file.FullName
    $targetPath = Join-Path -Path $targetDir -ChildPath $file.Name

    New-Item -ItemType SymbolicLink -Path $targetPath -Target $sourcePath
}
