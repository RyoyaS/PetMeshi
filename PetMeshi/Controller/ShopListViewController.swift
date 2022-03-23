//
//  TableViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/02.
//

import UIKit

class ShopListViewController: UITableViewController {
    
    var shopList : [StoreModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.shopList!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 200
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        let storeNameLable = cell.viewWithTag(1) as! UILabel
        storeNameLable.text = shopList![indexPath.row].name
        
        let storeAddressLable = cell.viewWithTag(2) as! UILabel
        storeAddressLable.text = shopList![indexPath.row].address
        
        let storeAccessLabel = cell.viewWithTag(3) as! UILabel
        storeAccessLabel.text = shopList![indexPath.row].access
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToShopDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShopDetail"{
            let shopDetailVC = segue.destination as! ShopDetailViewController
            navigationController?.pushViewController(shopDetailVC, animated: true)
        }
    }

}
