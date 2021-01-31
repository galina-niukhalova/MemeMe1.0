//
//  SentMemeViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 25/1/21.
//

import UIKit

class SentMemeViewController: UIViewController {
    let navigationTitle = "Sent Memes"
    let editorViewID = "EditorViewController"
    let detailsViewID = "DetailsViewController"
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        navigationItem.title = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addMeme))
    }
    
    @objc func addMeme() {
        let editorViewController = self.storyboard!.instantiateViewController(withIdentifier: editorViewID) as! EditorViewController
        
        navigationController!.pushViewController(editorViewController, animated: true)
    }
    
    func navigateToDetailsView(memeIndex: Int) {
        let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: detailsViewID) as! MemeDetailsViewController
        
        detailsViewController.memedImage = memes[memeIndex].memedImage
        
        navigationController!.pushViewController(detailsViewController, animated: true)
    }
}
