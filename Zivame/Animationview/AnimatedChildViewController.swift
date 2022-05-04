//
//  AnimatedChildViewController.swift
//  Zivame
//
//  Created by ram krishna on 03/05/22.
//

import UIKit

class AnimatedChildViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.img.rotate()
    }

}
