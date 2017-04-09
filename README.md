# Hotels
住哪儿App


![AppLogo](https://github.com/FantasticLBP/Hotels/blob/master/住哪儿/Assets.xcassets/AppIcon.appiconset/11.png?raw=true "这是App的Logo")




**实现了类似艺龙App的预定酒店功能，包括酒店搜索、特色酒店推荐、特惠酒店推荐等等功能，可以预定酒店、查看订单，唯独不能支付（支付功能必须由公司的名义注册，个人练手注册不了）。**
<ul>包括iOS开发的常见功能：
<li>自定义NavigationController实现全屏右滑返回上一控制器</li>
<li>UICollecionView展现界面</li>
<li>UITableview上拉加载、下面刷新功能</li>
<li>Masonry自动布局库的使用</li>
<li>封装好的启动欢迎页</li>
<li>YYModel字典转模型</li>
<li>复杂界面的布局</li>
<li>cell的重用内存优化</li>
<li>工程结构一幕了然，便于拓展</li>
<li>界面采用代码实现，部分界面采用xib实现。整个代码可读性比较好、代码规范、有注释说明，配合服务端是自己用php写的，Api也是php实现的。</li>
</ul>


<h3>效果截图</h3>

![App效果图](https://raw.githubusercontent.com/FantasticLBP/Hotels/master/1.gif "这是App的效果图")

<p>ToDo：后期可能会实现MVVM框架，将RAC技术应用到工程中去。一些容易变的页面采用Html5实现，比如"发现模块"的特色酒店。</p>

<h3>福利</h3>

<p>如果想了解服务端开发以及App与服务端交互（也就是接口开发）可以看看这个App的后台代码。项目地址：(https://github.com/FantasticLBP/Hotels_Server) <p>

<h3>住哪儿App的后台管理功能，包括主题酒店、特色酒店发布、注册用户的统计查看、订单的统计查看、酒店的统计查看。Controller目录下的Api下就是给App开发的api。想写api的童鞋们可以看看。</h3>
<ul>包括php系统开发的常见功能：
<li>复杂表单的提交，包括多图片上传</li>
<li>基于Bootstrap框架的界面布局</li>
<li>封装PDO数据库操作类，实现增删改查等等常见功能，调用简单</li>
<li>封装了Response类，可以传递4个参数 show($code, $message = '', $data = array(), $type = self::JSON)来展示json或者array或者xml。</li>
<li>工程结构一幕了然，便于拓展</li>
</ul>


如果有不懂的地方可以加入QQ交流群讨论：<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=c9dc4ab0b2062e0004b3b2ed556da1ce898631742e15780297feb3465ad08eda">**515066271**</a>。这个QQ群讨论技术范围包括：iOS、H5混合开发、前端开发、PHP开发，欢迎大家讨论技术。
