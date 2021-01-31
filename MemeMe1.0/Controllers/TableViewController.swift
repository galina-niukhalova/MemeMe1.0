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
    let noDataText = """
Please click + icon
to add your first meme
"""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Rerender table view if memes data has changed
        let numberOfRows = tableView.numberOfSections > 0 ? tableView.numberOfRows(inSection: 0) : 0
        if memes.count > 0 && memes.count > numberOfRows {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: Int = 0
        
        if memes.count > 0 {
            numOfSection = 1
            tableView.backgroundView = nil
        } else {
            // Display an empty placeholder when there is no meme
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.numberOfLines = 2
            noDataLabel.text = noDataText
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
        }
        
        return numOfSection
    }
}
