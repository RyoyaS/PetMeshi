//
//  StoreSearchManager.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import Foundation
import CoreLocation

struct StoreSerchManager {
    let storeSerchURL = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?"
    let apiKey = "5cbfd5c0656e9755"
    
    //検索用URLを作成
    func fetchSearchStore(lat : CLLocationDegrees,lng:CLLocationDegrees) {
        let urlString = "\(storeSerchURL)key=\(apiKey)&lat=\(lat)&lng=\(lng)&rang=4&pet=1&count=30&format=json"
        print(urlString)
        //リクエストを実施
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String) {
        //URLを作成
        if let url = URL(string: urlString){
            //URLSessionを作成
            let session = URLSession(configuration: .default)
            //sessionにタスクを与える
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            //タスクをスタートする
            task.resume()
        }
        
        
    }
    
    func handle(data : Data?, response : URLResponse?, error : Error?) -> Void {
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data{
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
}
