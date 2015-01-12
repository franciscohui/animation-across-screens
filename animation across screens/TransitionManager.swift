//
//  TransitionManager.swift
//  animation across screens
//
//  Created by Francisco Hui on 1/12/15.
//  Copyright (c) 2015 Francisco Hui. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // add presenting variable to check if animation screens are animating in or out
    private var presenting = true
   
    //MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // Animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
       
        // get reference to our formView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up from 2D transofrm that we'll use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        // prepare the toView for the animation
        //check to see if presenting is true or false, then update the animation accordingly
        if (self.presenting){
            toView.transform = offScreenRight
        }
        else{
            toView.transform = offScreenLeft
        }
        
        // add to both view our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        // this example just slides both the fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
            
            // slide fromView off either the left or the right edge fo the screen
            // depending if we're presenting or dismissing this view
            if (self.presenting){
                fromView.transform = offScreenLeft
            }
            else {
                fromView.transform = offScreenRight
            }
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                //tell our transitionContext that we've finished animating
                transitionContext.completeTransition(true)
        })
    }
    
    // return how many seconds the transition animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animator when presenting a viewcontroller
    // remember that an animator (or animation controller) is an object that adheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // set presenting to be true
        self.presenting = true
        return self
        
    }
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // set it to be false
        self.presenting = false
        return self
    }
}
