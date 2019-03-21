![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![](https://img.shields.io/vscode-marketplace/d/repo.svg)
![](https://img.shields.io/cocoapods/l/packageName.svg)


# GHAddressSelectDemo
电商省市区县镇选择器,下级数据动态从接口获取


![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-b83d31880e0c8b46.gif?imageMogr2/auto-orient/strip)

>有的项目地址是动态从服务器获取,在网上找了很多demo都是写死的,于是写了一个动态获取数据的地址选择器,同一类别点击任意一行都是请求的第一行数据.以下是接口,不需要入参,请求方式为post,参数放在请求头中,在使用的时候直接替换成你的接口和入参


接口

[https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getAllCitys](https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getAllCitys)

[https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHeNanCitys](https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHeNanCitys)

[https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHeNanCountys](https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHeNanCountys
)

[https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHenanOthers
](https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHenanOthers)


实现思路 
TODO