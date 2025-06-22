param(
    [Parameter(Mandatory=$true)]
    [string]$remoteUrl
)

# 检查是否提供了远程URL参数
if (-not $remoteUrl) {
    Write-Error "错误: 必须提供远程仓库URL参数"
    exit 1
}

$username = "shuai2.he";
git svn clone -r HEAD $remoteUrl --username $username;