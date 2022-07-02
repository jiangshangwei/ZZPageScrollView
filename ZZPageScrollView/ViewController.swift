//
//  ViewController.swift
//  ZZPageScrollView
//
//  Created by jsw_cool on 2022/7/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc:AViewController = AViewController.init(subvcTitiles: ["暗淡的速度dasd","2dads啊","312313123"])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

