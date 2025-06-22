# concatScript
用于拼接一个油猴脚本。  
> 使用某些框架或者构建工具，会生成难以阅读的js文件，并且需要将这些文件的内容嵌入到油猴脚本中，这个过程是没有意义且繁琐的，故而创建此脚本。  

## 使用示例
需要注意的是，powershell中的参数使用-而不是--。  
```ps1
concatScript -meta ./template.user.js -css ../dist/static/css/ -js ../dist/static/js/ -output output.user.js
```
meta为元信息，是油猴的脚本头。
```js
// ==UserScript==
// @name         鼠标摇滚手势滚动控制
// @namespace    http://dreamsoul.cn/
// @version      1.0.0
// @description  通过同时按下鼠标左右键并移动来滚动页面
// @author       魂祈梦
// @match        *://*/*
// @grant        GM_registerMenuCommand
// @grant        GM_getValue
// @grant        GM_setValue
// @grant        GM_addStyle
// @run-at       document-idle
// @noframes
// ==/UserScript==
```

-css即css文件，可以使用less等预编译工具，将css编译到同一个文件中。  
```css
body{
    margin: 0;
    padding: 0;
}
.main{
    display: flex;
    padding: 10px;
}
```

-js即js文件目录（注意是目录而不是文件）。  

-output为输出路径。  