//
//  TableViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 21/1/21.
//

import Foundation
import UIKit

class TableViewController: SentMemeViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let tableCellID = "MemeTableCellIdentifier"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Rerender table view if memes data has changed
        if memes.count > tableView.numberOfRows(inSection: 0) {
            tableView.reloadData()
        }
    }
    
    // MARK: Table data
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! MemeTableViewCell
        
        let meme = memes[indexPath.row]
        cell.memeImage.image = meme.memedImage
        cell.memeLabel.text = "\(meme.topText)...\(meme.bottomText)"
        
        return cell
    }
    
    // MARK: Navigate to details view on a table's item click
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailsView(memeIndex: indexPath.row)
    }
}
