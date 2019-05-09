![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![](https://img.shields.io/vscode-marketplace/d/repo.svg)
![](https://img.shields.io/cocoapods/l/packageName.svg)


# GHAddressSelectDemo
电商省市区县镇选择器,下级数据动态从接口获取


![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-b83d31880e0c8b46.gif?imageMogr2/auto-orient/strip)

### 需求
>有的项目地址是动态从服务器获取,在网上找了很多`demo`都是写死的,于是写了一个动态获取数据的地址选择器,同一类别点击任意一行都是请求的第一行数据.以下是接口,不需要入参,请求方式为`post`,参数放在请求头中,在使用的时候直接替换成你的接口和入参

### 使用方法

![1-2.png](https://upload-images.jianshu.io/upload_images/1419035-4fbe9eabc57dab4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 接口

[https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getAllCitys](https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getAllCitys)


![2-2.png](https://upload-images.jianshu.io/upload_images/1419035-9086794cb62f7fee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 实现思路 

* 创建两个`scrollView`分别在顶部用来存放用户选择的信息,顶部的`scrollView`用来切换省,市,区,县...
* 默认创建一个省级的`tableView`装升级的数据

![5.png](https://upload-images.jianshu.io/upload_images/1419035-e6ea6e55fabcffb3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 每次用户的选择的时候再创建一个`tableView `,同时发送请求请求下级数据,请求到数据之后把滑动`scrollView `到当前的`tableView `

