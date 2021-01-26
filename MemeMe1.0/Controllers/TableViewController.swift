//
//  TableViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 21/1/21.
//

import Foundation
import UIKit

class TableViewController: NavigationViewController, UITableViewDataSource, UITableViewDelegate {
    var memes = (UIApplication.shared.delegate as! AppDelegate).memes
    let tableCellID = "MemeTableCellIdentifier"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print(memes)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memes)
        return memes.count
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath)
        
        cell.textLabel!.text = memes[indexPath.row].topText
        
        return cell
    }
}
