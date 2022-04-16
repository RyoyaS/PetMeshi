//
//  CustomUINavigationController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/04/09.
//

import UIKit

class CustomUINavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
