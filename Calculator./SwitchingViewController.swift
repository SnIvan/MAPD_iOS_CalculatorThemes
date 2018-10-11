//
//  SwitchingViewController.swift
//  Calculator.
//
//  Created by Ivan on 2018-10-11.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    private var ViewController: ViewController!
    private var DarkViewController: DarkViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController = storyboard?.instantiateViewController(withIdentifier: "White") as! ViewController
        
        ViewController.view.frame = view.frame
        switchViewController(from: nil, to: ViewController)
        // helper method
    }
    

    @IBAction func switchViews(sender: UIBarButtonItem) {
        //Create the new view controller,  if required
        if DarkViewController?.view.superview == nil {
            if DarkViewController == nil {
                DarkViewController = storyboard?.instantiateViewController(withIdentifier: "Dark") as!
                DarkViewController
            }
        } else if ViewController?.view.superview == nil {
            if ViewController == nil {
                ViewController = storyboard?.instantiateViewController(withIdentifier: "White") as!
                ViewController
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        //Switch View Controllers
        if ViewController != nil && ViewController!.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            DarkViewController.view.frame = view.frame
            switchViewController(from: ViewController, to: DarkViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            ViewController.view.frame = view.frame
            switchViewController(from: DarkViewController, to: ViewController)
        }
        UIView.commitAnimations()
    }
    
    private func switchViewController(from fromVC:UIViewController?, to toVC:UIViewController?) {
        
        if fromVC != nil {
            fromVC!.willMove(toParentViewController: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParentViewController: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if ViewController != nil && ViewController!.view.superview == nil {
            ViewController = nil
        }
        if DarkViewController != nil && DarkViewController!.view.superview == nil {
            DarkViewController = nil
        }
    }
    
}
