//
//  ShopDetailViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/06.
//

import UIKit

class StoreDetailViewController: UIViewController{

    var name = ""
    @IBOutlet weak var shopNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
