//
//  TableViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/02.
//

import UIKit
import CoreLocation
import GoogleMobileAds

class StoreListViewController: UITableViewController {
    
    var storeList: [StoreModel]?
    var selectedStore: StoreModel?
    var resultNum : Int?
    var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "検索結果\(resultNum!)件"
        
        UITableView.appearance().backgroundColor = UIColor.white
    }
    
    //リストのセル数を決める
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList!.count
    }
    
    //セルを作成する
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 180
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: K.storeCellID, for: indexPath)
        let storeNameLable = cell.viewWithTag(1) as! UILabel
        storeNameLable.text = storeList![indexPath.row].name
        
        let storeAddressLable = cell.viewWithTag(2) as! UILabel
        storeAddressLable.text = storeList![indexPath.row].address
        
        let storeAccessLabel = cell.viewWithTag(3) as! UILabel
        storeAccessLabel.text = storeList![indexPath.row].access
        
        let distanceLabel = cell.viewWithTag(4) as! UILabel
        let storeLocation = CLLocation(latitude: storeList![indexPath.row].lat, longitude: storeList![indexPath.row].lng)
        let distance = storeLocation.distance(from: userLocation!)
        distanceLabel.text = "店まで\(String(format: "%.0f", distance))m"
        
        return cell
    }
    
    //選択したセルの詳細ページに遷移
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStore = storeList![indexPath.row]
        self.performSegue(withIdentifier: K.storeDetailSegue, sender: self)
    }
    
    //遷移先に店情報を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.storeDetailSegue{
            let storeDetailVC = segue.destination as! StoreDetailViewController
            storeDetailVC.store = selectedStore
        }
    }

}
