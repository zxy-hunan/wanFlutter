# Flutter学习总结
wanAndroid的Flutter版本。

Widget:Flutter中Widget是不可变的，不会直接更新，而必须使用Widget的状态.Stateful和Stateless;

如何布局：在Flutter中，使用widget树来编写布局。

跳转：Navigator可以通过push和pop route以实现页面切换。

资源文件：Flutter遵循像iOS这样简单的3种分辨率格式: 1x, 2x, and 3x.创建一个名为images的文件夹，并为每个图像文件生成一个@2x和@3x文件，并将它们放置在如下这样的文件夹中，然后，您需要在pubspec.yaml文件中声明这些图片

远程依赖：pubspec.yaml

### 实现效果

<img src="/screenshot/1.png" width="285"/>

<img src="/screenshot/2.png" width="285"/>

<img src="/screenshot/3.png" width="285"/>