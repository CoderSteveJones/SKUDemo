//
//  ViewController.swiftontroller.swift
//  SKUDemo
//
//  Created by 江奔 on 2018/3/28.
//  Copyright © 2018年 yueyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showClick(_ sender: UIButton) {
        setupModalView()
    }
    
}

extension ViewController {
    
    fileprivate func setupModalView() {
        
        let standardsVC = GoodsStandardsController()
        standardsVC.modalPresentationStyle = .custom
        standardsVC.transitioningDelegate = self as UIViewControllerTransitioningDelegate
        present(standardsVC, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopPresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopDismissAnimation()
    }
    
}

