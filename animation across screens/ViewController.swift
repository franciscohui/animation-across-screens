//
//  ViewController.swift
//  animation across screens
//
//  Created by Francisco Hui on 1/7/15.
//  Copyright (c) 2015 Francisco Hui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transitionManager = TransitionManager()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a refernce to the screen we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask 
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func unwindToViewCtonroller (sender: UIStoryboardSegue){
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

