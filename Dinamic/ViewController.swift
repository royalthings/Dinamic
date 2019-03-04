//
//  ViewController.swift
//  Dinamic
//
//  Created by Dima on 2/4/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myImageView = [UIDynamicItem]()
    var myDynamic = UIDynamicAnimator()
    
    var myGravity = UIGravityBehavior()
    var myCollision = UICollisionBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
        
        createImage()
        createGravity()
        createCollision()
        
    }
    
        func createImage() {
        
        
        let numbetOfView = 2
        myImageView.reserveCapacity(numbetOfView)
        var currentCenterPoint = CGPoint(x: 180, y: 100)
        let eachImageSize = CGSize(width: 50, height: 50)
        
        for _ in 0..<numbetOfView {
            let myImage = UIImageView(frame: CGRect(x: 0, y: 0, width: eachImageSize.width, height: eachImageSize.height))
            myImage.center = currentCenterPoint
            myImage.image = UIImage(named: "apple")
            currentCenterPoint.y += eachImageSize.height + 10
            self.view.addSubview(myImage)
            
            myImageView.append(myImage)
    
        }
    }
        func createGravity() {
            myDynamic = UIDynamicAnimator(referenceView: view)
            myGravity = UIGravityBehavior(items: myImageView)
            myGravity.magnitude = 0.4
            //myGravity.angle = 0.1
            
            myDynamic.addBehavior(myGravity)
            
        }
    func createCollision() {
        myCollision = UICollisionBehavior(items: myImageView)
        myCollision.translatesReferenceBoundsIntoBoundary = true
        myCollision.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: self.view.bounds.size.height - 100), to: CGPoint(x: self.view.bounds.size.width, y: self.view.bounds.size.height - 100))
        
        myCollision.collisionDelegate = self
        myDynamic.addBehavior(myCollision)
    }
        
        
            
    
        
        /*
        myImageView = UIImageView(image: myImage)
        myImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        myImageView.center = self.view.center
        self.view.addSubview(myImageView)
    }*/
    
   /* func createGravity() {
        myDynamic = UIDynamicAnimator(referenceView: view)
        myGravity = UIGravityBehavior(items: [myImageView])
        myGravity.magnitude = 0.3
        //myGravity.angle = 0.2
        myDynamic.addBehavior(myGravity)
    }
    
    func createCollision() {
        myCollision = UICollisionBehavior(items: [myImageView])
        myCollision.translatesReferenceBoundsIntoBoundary = true
        myCollision.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: self.view.bounds.size.height - 100), to: CGPoint(x: self.view.bounds.size.width, y: self.view.bounds.size.height - 100))
        myDynamic.addBehavior(myCollision)
    }*/
    

}

extension ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        let identifier = identifier as? String
        let kBootom = "bottom"
        if identifier == kBootom {
            UIView.animate(withDuration: 1.0, animations: {
                let view = item as? UIView
                view?.alpha = 0.0
                view?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }) { (finish) in
                let view = item as? UIView
                behavior.removeItem(item)
                view?.removeFromSuperview()
            }
        }
    }
    
    
}
