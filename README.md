系统安装部署
数据库部分：

> 1.先建一个名为easyshoppingcart的空数据库。
> 2.执行数据库脚本（最好用navicat for mysql执行）。

系统部分：
> 1.用eclipse导入项目。
> 2.在src目录下的easyshopping.properties文件中修改数据库连接名和用户名及密码。
> 3.编译打包后就可发布到tomcat或其他服务器运行（端口8080）。

部署成功后访问首页地址：
http://localhost:8080/easy-shopping/
后台管理访问地址：（登录名和密码均为admin）
http://localhost:8080/easy-shopping/admin/


系统首次使用说明：
> 1.进入后台管理页面并登录。

> 2.进入如下所示选项，点击“确定”来清除之前的缓存。
![cmd-markdown-logo](http://imgsrc.baidu.com/forum/w%3D580/sign=a7c46a2882d4b31cf03c94b3b7d6276f/ecd45cec8a1363278ff9b358988fa0ec08fac756.jpg)
![cmd-markdown-logo]
(http://p5.qhimg.com/t01493751ec7b29f532.png)


> 3.以上步骤完成后，商城可正常访问。

## License

- 本项目的所有代码除另有说明外,均按照 [MIT License](http://rem.mit-license.org) 发布。
- 本项目的README.MD，wiki等资源基于 [CC BY-NC-SA 4.0][CC-NC-SA-4.0] 这意味着你可以拷贝、并再发行本项目的内容，<br/>
  但是你将必须同样**提供原作者信息以及协议声明**。同时你也**不能将本项目用于商业用途**，按照我们狭义的理解<br/>
  (增加附属条款)，凡是**任何盈利的活动皆属于商业用途**。
- 请在遵守当地相关法律法规的前提下使用本项目。

![img-source-from-https://github.com/docker/dockercraft](https://github.com/docker/dockercraft/raw/master/docs/img/contribute.png?raw=true)

[github-hosts]: https://raw.githubusercontent.com/racaljk/hosts/master/hosts "hosts on Github"
[CC-NC-SA-4.0]: https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh
