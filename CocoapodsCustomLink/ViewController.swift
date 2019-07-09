//
//  ViewController.swift
//  CocoapodsCustomLink
//
//  Created by tetsuya_kojima on 2019/07/09.
//  Copyright © 2019 com.kotalab. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    static func instantiate() -> ViewController {
        return UIStoryboard(name: "Storyboard", bundle: .main).instantiateInitialViewController() as! ViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
