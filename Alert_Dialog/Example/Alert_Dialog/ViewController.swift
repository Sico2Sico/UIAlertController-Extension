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

