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
