$filename = $args[0]
$url = $args[1]
$content = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="0;url=$url">
<title>Redirecting</title>
</head>
<body>
</body>
</html>
"@

echo $content > $filename