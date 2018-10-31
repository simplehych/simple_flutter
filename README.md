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


Q: List data; 没有默认值，不是null

A: 所以需要初始化，不能用 if(data ==null) 判断，在界面显示会加载不出来
