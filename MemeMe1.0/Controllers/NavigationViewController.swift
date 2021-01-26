//
//  NavigationViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 25/1/21.
//

import UIKit

class NavigationViewController: UIViewController {
    override func viewDidLoad() {
        navigationItem.title = "Sent Memes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addMeme))
    }
    
    @objc func addMeme() {
        let editorViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditorViewController") as! EditorViewController
        
        navigationController!.pushViewController(editorViewController, animated: true)
    }
}
