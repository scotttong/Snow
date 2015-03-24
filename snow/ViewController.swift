//
//  ViewController.swift
//  snow
//
//  Created by Scott Tong on 3/23/15.
//  Copyright (c) 2015 Scott Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
	
	var animator: UIDynamicAnimator!
	var gravity: UIGravityBehavior!
	var collision: UICollisionBehavior!
	
	var snowflake: UIView!


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		animator = UIDynamicAnimator(referenceView: self.view)
		gravity = UIGravityBehavior()
		collision = UICollisionBehavior()
		
		collision.collisionDelegate = self

		
		// create a boundary of the roof
		collision.addBoundaryWithIdentifier("roof", fromPoint: CGPointMake(0, self.view.frame.height/2), toPoint: CGPointMake(150, self.view.frame.height/2 + 90))

		// create a floor boundary
		collision.addBoundaryWithIdentifier("ground", fromPoint: (CGPointMake(0, 667)), toPoint:  CGPointMake(375, 667))

		
		onTimer()
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func snowing () {
		
		var snowflake = UIView(frame: CGRect(x: CGFloat(arc4random_uniform(375)), y: CGFloat(0), width: CGFloat(10), height: CGFloat(10)))
		snowflake.backgroundColor = UIColor.whiteColor()
		view.addSubview(snowflake)
		
	}
	
	// colliding with the floor
	func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
		
		// these constants refer to the parameters in the function
		let boundaryIdentifier = identifier as String
		let view = item as UIView
		
		if boundaryIdentifier == "ground" {
			
			UIView.animateWithDuration(0.1, animations: { () -> Void in
				view.alpha = 0
			}, completion: { (Bool) -> Void in
				view.removeFromSuperview()
			})
		}
		

		
		
	}
	
	// creating snowflakes on a timer
	func onTimer() {

		snowflake = UIView(frame: CGRect(x: CGFloat(arc4random_uniform(375)), y: CGFloat(0), width: CGFloat(10), height: CGFloat(10)))
		snowflake.backgroundColor = UIColor.whiteColor()
		snowflake.layer.cornerRadius = 5
		view.addSubview(snowflake)
		gravity.addItem(snowflake)
		gravity.gravityDirection = CGVectorMake(0, 0.1)
		animator.addBehavior(gravity)
		animator.addBehavior(collision)
		
		collision.addItem(snowflake)


		NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onTimer", userInfo: nil, repeats: false)

		
	}


}

