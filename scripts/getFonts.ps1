# 定义脚本参数：支持接收多个模糊搜索关键词
param(
    [Parameter(Mandatory=$false, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Keywords  # 示例调用：.\getFonts.ps1 "Arial*" "*Bold*" 
)

# 读取注册表中的字体列表
$fontPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
$fonts = Get-ItemProperty -Path $fontPath

# 过滤掉系统属性（如 PSPath、PSParentPath 等）
$fontList = $fonts.PSObject.Properties | 
    Where-Object { $_.Name -notmatch '^PS' }  # 排除系统属性

# 无参数时输出所有字体
if (-not $Keywords) {
    $fontList | Select-Object Name, Value
    exit
}

# 处理多个关键词的模糊搜索（并集）
$results = @()
foreach ($keyword in $Keywords) {
    # 将通配符 * 和 ? 转换为正则表达式语法
    $pattern = $keyword -replace '\*', '.*' -replace '\?', '.'
    # 不区分大小写匹配，并收集结果
    $matches = $fontList | 
        Where-Object { $_.Name -match $pattern } 
    $results += $matches
}

# 去重并输出
$results | 
    Sort-Object Name -Unique | 
    Select-Object Name, Value