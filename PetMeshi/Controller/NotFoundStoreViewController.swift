//
//  NotFoundStoreViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import UIKit

class NotFoundStoreViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = UIAlertController(title: "お店が見つかりません", message: "位置情報がオフになっているか\n近くにお店がありません", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }


    
}
