//
//  HomeViewController.swift
//  V2ex_iOS
//
//  Created by zippo on 9/20/18.
//  Copyright © 2018 zippo. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        V2exAPIService.shared.get_hotest(completion_handler: localDataBaseService.shared.updateWithThreadJsonDict(_:))
    }
}
