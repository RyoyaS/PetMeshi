//
//  ShowURLPhoto.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/04/10.
//

import UIKit

struct ShowURLPhoto{
    //URL画像設定関数
    func showURLPhoto(photoUrl: String?) -> UIImage{
        if let urlString = photoUrl{
            let url = URL(string: urlString)
            do{
                let imageData = try Data(contentsOf: url!)
                return UIImage(data: imageData)!
                
            } catch {
                print("Error : Cat't get image")
            }
        }
        return UIImage(named: K.noPhoto)!
    }
}
