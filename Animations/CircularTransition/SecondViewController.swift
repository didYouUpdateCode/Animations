//
//  SecondViewController.swift
//  CircularTransitionAnimation
//
//  Created by Hank Chiang on 2017/3/25.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
}
