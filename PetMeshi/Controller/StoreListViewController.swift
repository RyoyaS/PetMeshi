//
//  TableViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/02.
//

import UIKit

class StoreListViewController: UITableViewController {
    
    var storeList: [StoreModel]?
    var selectedStoreName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 200
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: K.storeCellID, for: indexPath)
        let storeNameLable = cell.viewWithTag(1) as! UILabel
        storeNameLable.text = storeList![indexPath.row].name
        
        let storeAddressLable = cell.viewWithTag(2) as! UILabel
        storeAddressLable.text = storeList![indexPath.row].address
        
        let storeAccessLabel = cell.viewWithTag(3) as! UILabel
        storeAccessLabel.text = storeList![indexPath.row].access
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStoreName = storeList![indexPath.row].name
        self.performSegue(withIdentifier: K.storeDetailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.storeDetailSegue{
            let storeDetailVC = segue.destination as! StoreDetailViewController
            if let safeSelectedStoreName = selectedStoreName{
                storeDetailVC.name = safeSelectedStoreName
            }
        }
    }

}
