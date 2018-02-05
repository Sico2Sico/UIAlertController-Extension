# Alert_Dialog

[![CI Status](http://img.shields.io/travis/Sico2Sico/Alert_Dialog.svg?style=flat)](https://travis-ci.org/Sico2Sico/Alert_Dialog)
[![Version](https://img.shields.io/cocoapods/v/Alert_Dialog.svg?style=flat)](http://cocoapods.org/pods/Alert_Dialog)
[![License](https://img.shields.io/cocoapods/l/Alert_Dialog.svg?style=flat)](http://cocoapods.org/pods/Alert_Dialog)
[![Platform](https://img.shields.io/cocoapods/p/Alert_Dialog.svg?style=flat)](http://cocoapods.org/pods/Alert_Dialog)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Alert_Dialog is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Alert_Dialog'
```



## 样例



![3BDC43DF-B01F-4F64-BB08-D60874BA9B8F](/Users/wudezhi/Library/Containers/com.tencent.qq/Data/Library/Application Support/QQ/Users/494712390/QQ/Temp.db/3BDC43DF-B01F-4F64-BB08-D60874BA9B8F.png)

## 使用说明

```swift
//
//  ViewController.swift
//  Alert_Dialog
//
//  Created by Sico2Sico on 02/05/2018.
//  Copyright (c) 2018 Sico2Sico. All rights reserved.
//

import UIKit
import Alert_Dialog
import ReactiveSwift
import ReactiveCocoa
import Result

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        let newView = UIControl()
        newView.backgroundColor = UIColor.red

        let alret  = UIAlertController(customView: newView) { (make) in
            make.size.equalTo(300)
            make.center.equalToSuperview()
        }

        newView.reactive
            .controlEvents(UIControlEvents.touchUpInside)
            .observeValues {[weak alret] (view) in
                print("处理问题")
                alret!.dismiss(animated:true, completion:nil)
        }

        alret.show()

    }


}

```



## 源文件

```swift
//
//  UIAlertController+Dialog.swift
//  AppUIKit
//
//  Created by 德志 on 2018/2/5.
//

import UIKit
import SnapKit

extension UIAlertController {
    
    public convenience init(customView : UIView, closure:@escaping (_ make: ConstraintMaker) -> Void){
        self.init(title:nil, message:nil, preferredStyle: UIAlertControllerStyle.alert)
        view.clipsToBounds = false

        customView.tag = 1111
        view.addSubview(customView)

        // 这里需要加一个action 不然会报错
        let action = UIAlertAction(title:"", style: .default, handler:nil)
        addAction(action)

        //约束
        customView.snp.makeConstraints { (make) in
            closure(make)
        }

        // 隐藏系统的View
        _ = self.view.subviews.flatMap { (view) -> Void in
            if view.tag != 1111 {
                view.isHidden = true
            }else {
                view.isHidden = false
            }
        }
    }



    public func show(animated: Bool = true, style: UIBlurEffectStyle? = nil, completion: (() -> Void)? = nil) {

        if let style = style {
            for subview in view.allSubViewsOf(type: UIVisualEffectView.self) {
                subview.effect = UIBlurEffect(style: style)
            }
        }

        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        }
    }

}
```







## Author

Sico2Sico, wu.dz@aiiage.com

## License

Alert_Dialog is available under the MIT license. See the LICENSE file for more info.
