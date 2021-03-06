//
//  CollectionViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 21/1/21.
//

import Foundation
import UIKit

class CollectionViewController: SentMemeViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    let collectionCellID = "MemeCollectionCellIdentifier"
    
    func setCollectionStyling() {
        let space: CGFloat = 3.0
        
        // set 3 items in a row for Portrait orientation and 6 items in a row of Landscape one
        let dimension = view.frame.width < view.frame.height
            ? (view.frame.width - (2 * space)) / 3.0
            : (view.frame.width - (5 * space)) / 6.0
        
        // The minimum spacing to use between items in the same row.
        flowLayout.minimumInteritemSpacing = space
        // The minimum spacing to use between lines of items in the grid.
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setCollectionStyling()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Rerender collection view if memes data has changed
        if memes.count > collectionView.numberOfItems(inSection: 0) {
            collectionView.reloadData()
        }
    }
    
    // MARK: Collection data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! MemeCollectionViewCell
        
        cell.memeImage.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    // MARK: Navigate to details view on a collection's item click
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetailsView(memeIndex: indexPath.row)
    }
}
