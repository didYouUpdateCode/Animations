//
//  ViewController.swift
//  CircularTransitionAnimation
//
//  Created by didYouUpdateCode on 2017/3/25.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! SecondViewController
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
    }
}

extension FirstViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startPoint = addButton.center
        transition.circleColor = addButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startPoint = addButton.center
        transition.circleColor = addButton.backgroundColor!
        
        return transition
    }
}
