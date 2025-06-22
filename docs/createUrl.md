# createUrl
用于创建一个网页快捷方式。  
由于windows的快捷方式并不适用于其他系统，因此我们可以使用该方法来创建一个全平台通用的网页快捷方式。  
## 使用
powershell可以忽略大小写
```pwsh
createurl 必应 https://www.bing.com
```
如此一来，会创建一个bing的书签，原理是静态html重定向。  

