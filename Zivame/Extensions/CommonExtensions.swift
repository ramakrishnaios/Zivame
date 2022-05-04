//
//  CommonExtensions.swift
//  Zivame
//
//  Created by ram krishna on 03/05/22.
//

import Foundation
import UIKit
extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            viewControllers.last?.willMove(toParent: nil)
            viewControllers.last?.removeFromParent()
            viewControllers.last?.view.removeFromSuperview()
        }
    }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
