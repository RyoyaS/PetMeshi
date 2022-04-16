//
//  AdManager.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/04/12.
//

import Foundation
import GoogleMobileAds

struct AdManager{
    //広告ユニットIDを設定する
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }

    
}
