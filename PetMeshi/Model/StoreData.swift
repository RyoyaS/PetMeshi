//
//  StoreData.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/01.
//

import Foundation



struct StoreData : Codable{
    let results : Results
}

struct Results : Codable{
    let shop : [Shop]
}

struct Shop :Codable{
    let access : String
    let address :String
    let name : String
    let genre : Genre
    let urls : Urls
}

struct Genre : Codable{
    let name : String
}

struct Urls : Codable{
    let pc : String
}
