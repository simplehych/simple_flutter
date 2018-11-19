# simple_flutter

A new Flutter project.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

GSYGithubAppFlutter系列学习相关的：

https://www.jianshu.com/p/533b5b8d2f71

https://yq.aliyun.com/teams/290/type_blog-cid_0-page_1?spm=a2c4e.11153959.0.0.704b616bmn7sDg#tab

Q:运行ios问题，"platforms":{"ios","7.0"}, Error pod install

A:https://blog.csdn.net/u013242081/article/details/78584117


Q:Error: No StoreProvider<dynamic> found

A:第二个页面使用StoreBuilder时注意后面跟泛型，(使用routers进行跳转，第一个name需要为“/”)

Q:setState{}每次调用刷新页面数据是只刷新数据改变的Widget还有所有遍历

Q:Toast.LENGTH_SHORT和自己命名的类重复问题解决

Q:使用json build runner时报错The current Dart SDK version is 2.1.0-dev.6.0.flutter-a50dfd6698. Because build_runner >=0.9.1+1 <0.10.3 depends on build >=0.12.7 <0.12.8 and build >=0.0.1+1 <=0.12.7 requires SDK version <2.0.0 or >=2.0.0-dev.9 <2.0.0, build_runner >=0.9.1+1 <0.10.3 requires build >=0.12.7+2 <0.12.8.

A: 注释掉dev_dependencies:下的flutter_test:sdk: flutter

Q: Future的使用

A: http://flutter.link/2018/04/12/Dart%E4%B8%AD%E7%9A%84%E5%BC%82%E6%AD%A5%E6%93%8D%E4%BD%9C/


Q: List data; 没有默认值，不是null??????????  验证结果默认值是null

A: 所有类型没有初始化的值都是null，包括int；所以需要初始化，不能用 if(data ==null) 判断，在界面显示会加载不出来,好像不是。。。。。,在ListView.buildItem可能不能返回Container()所以渲染不出来，需要给Container添加child


Q: BottomNavigationBar设置背景色

A: 目前暂未找到，或许可以外加布局嵌套，但是设置背景的嵌套布局没有找到,backgroundColor在fixed模式下无效

Q: 数据库sqflite的使用，替换为关键字的名字，如id，order等；还有使用List<dynamic>怎么处理

A: 暂未发现

Q: 数据库查询使用where in

A: db.delete("table","phoneNumber in (?)","'10086,'10010'")   select * from tableName where phoneNumber in ('10086','10010')

Q: 波纹

A: InkWell  RaiseButton


Q: RefreshIndicator 有返回值

A: return 之后则消失，假如加async马上消失，不加不消失

Q: This Overlay widget cannot be marked as needing to build because the framework is already in the
    process of building widgets. A widget can be marked as needing to be built during the build phase
   only if one of its ancestors is currently building. This exception is allowed because the framework
    builds parent widgets before children, which means a dirty descendant will always be  Otherwise, the framework might not visit this widget during this build phase.
    
A: 报错很难发现问题的所在，之前报错原因是Splash页面 Future.delayed( const Duration(seconds: 2),_goPageChoice,);把_goPageChoice改成了    NavigatorManager.goMainPage(context);  使得语法错误导致

Q: flutter_webview_plugin报错

A: 重新依赖一下


Q: 加载WebView，在Ios不显示

A: withLocalUrl 是否设置该参数，默认为false没有问题

Q: 不满一屏幕时，通过_scrollController.addListener()不能触发滚动监听

A: 待解决

Q: children: allSections.map<Widget>((Section section) {
                             return Column(
                               crossAxisAlignment: CrossAxisAlignment.stretch,
                               children: _detailItemsFor(section).toList(),
                             );
                           }).toList()
                           
A: 常用转换手法


Q: Center child只有一个布局时才生效，使用Row和Column都无效。。。。。

A: ???????



Q: Duplicate GlobalKey detected in widget tree.

A: 例如Login页面和Register页面， 取消掉Login页面的passwordGlobalKey就不会奔溃了，但还是会报错,TextFormField导致的，暂时处理方式都去掉，使用TextEditingController进行操作

Q: 使用pod install 出现bad interpreter: No such file or directory

A: 更新了系统安全性导致   $ sudo gem update --system   $ sudo gem install cocoapods -n/usr/local/bin




android 源码编译
https://mp.weixin.qq.com/s/FFCeraDXcoCP8eJtxS3KWA
https://github.com/anggrayudi/android-hidden-api
https://www.jianshu.com/p/9bf96f648884
https://www.jianshu.com/p/367f0886e62b

https://blog.csdn.net/guolin_blog/article/details/9097463
https://blog.csdn.net/guolin_blog/article/details/48719871
https://blog.csdn.net/guolin_blog/article/details/12921889

Flutter
https://www.jianshu.com/p/8baa8ed2414d

0.67
0.75

Binder机制
https://blog.csdn.net/freekiteyu/article/details/70082302

VIew
https://www.jianshu.com/p/e9d8420b1b9c

贝塞尔曲线
https://www.jianshu.com/p/55c721887568

carson_Ho
https://www.jianshu.com/u/383970bef0a0

面试
https://mp.weixin.qq.com/s/ozurrujmIfEhHJuVGsNv9A

understand
https://www.cnblogs.com/zhangyang/p/7602485.html

Q: Android license status unknown.

A: flutter doctor --android-licenses
