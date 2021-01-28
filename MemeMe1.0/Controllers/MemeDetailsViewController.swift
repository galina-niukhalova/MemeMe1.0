//
//  MemeDetailsViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 28/1/21.
//

import UIKit

class MemeDetailsViewController: UIViewController {
    var memedImage: UIImage!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = memedImage
    }
}
