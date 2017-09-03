# Hotels

住哪儿App



![AppLogo](https://github.com/FantasticLBP/Hotels/blob/master/住哪儿/Assets.xcassets/AppIcon.appiconset/11.png?raw=true "这是App的Logo")

[![platform](https://img.shields.io/badge/platform-iOS-red.svg)]()
[![weibo](https://img.shields.io/badge/weibo-%40杭城小刘-green.svg)](http://weibo.com/3194053975/profile?rightmod=1&wvr=6&mod=personinfo&is_hot=1)
[![Updated](https://img.shields.io/badge/Updated-2017--07--20-brightgreen.svg)]()



**实现了类似艺龙App的预定酒店功能，包括酒店搜索、特色酒店推荐、特惠酒店推荐等等功能，可以预定酒店、查看订单，唯独不能支付（支付功能必须由公司的名义注册，个人练手注册不了）。**
<ul>包括iOS开发的常见功能：
<li>自定义NavigationController实现全屏右滑返回上一控制器的LBPNavigationController</li>
<li>自定义UIScrollView实现全屏滑动显示不同控制器的LBPScrollSegmentView</li>
<li>封装网络访问类AFNetPackage，具备检查网络状态、JSON方式获取数据、xml方式获取数据、post、get、delete、文件下载、文件上传等功能</li>
<li>UITableview上拉加载、下面刷新功能;UITableView潜逃UICollecionView展现界面，事件、数据等通过Delegate处理</li>
<li>Masonry自动布局库的使用</li>
<li>封装好的启动欢迎页</li>
<li>个人信息持久化保存</li>
<li>复杂界面的布局纯代码实现</li>
<li>cell的重用内存优化</li>
<li>自定义URL Schemes便于其他App或者网页唤起；方便App或者网页传递参数</li>
<li>工程结构一幕了然，便于拓展</li>
<li>界面采用代码实现，部分界面采用xib实现。整个代码可读性比较好、代码规范、有注释说明，配合服务端是自己用php写的，Api也是php实现的。</li>
<li>主要功能：根据不同主题查找酒店、摇一摇随机推荐酒店、根据城市定位推荐酒店、根据用户输入多条件模糊搜索查找酒店、酒店位置地图显示、路径规划及其导航（百度地图、高德地图、系统地图）、订单查看等、酒店分享等功能</li>
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
<li>随机酒店推荐策略</li>
<li>多条件模糊搜索酒店算法</li>
<li>jquery表格插件Datatables的使用大大丰富了数据的展现方式，更具交互性。具有自动分页、模糊搜索等功能</li>
<li>封装了Response类，可以传递4个参数 show($code, $message = '', $data = array(), $type = self::JSON)来展示json或者array或者xml。</li>
<li>工程结构一幕了然，便于拓展</li>
</ul>

<h3>效果截图</h3>

![系统截图](https://github.com/FantasticLBP/Hotels_Server/blob/master/Systemt_Screen1.png?raw=true "这是系统截图")


各位同学觉得有帮助的欢迎给个star，我会继续优化代码。
如果有不懂的地方可以加入QQ交流群讨论：<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=c9dc4ab0b2062e0004b3b2ed556da1ce898631742e15780297feb3465ad08eda">**515066271**</a>。这个QQ群讨论技术范围包括：iOS、H5混合开发、前端开发、PHP开发，欢迎大家讨论技术。
