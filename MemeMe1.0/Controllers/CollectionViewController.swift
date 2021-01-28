//
//  CollectionViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 21/1/21.
//

import Foundation
import UIKit

class CollectionViewController: NavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    let collectionCellID = "MemeCollectionCellIdentifier"
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let numberOfItemsInRow: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / numberOfItemsInRow
        let height = dimension * 1.5 //ratio
        
        // make sure it works in both landscape and portrait mode
        
        // The minimum spacing to use between items in the same row.
        flowLayout.minimumInteritemSpacing = space
        // The minimum spacing to use between lines of items in the grid.
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: height)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Rerender collection view if memes data has changed
        if memes.count > collectionView.numberOfItems(inSection: 0) {
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
//        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! MemeCollectionViewCell
    
        cell.memeImage.image = memes[indexPath.row].memedImage
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailsViewController") as! MemeDetailsViewController
        
        detailsViewController.memedImage = memes[indexPath.row].memedImage
        
        navigationController!.pushViewController(detailsViewController, animated: true)
    }
}
