//
//  StoreSearchManager.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import Foundation
import CoreLocation

protocol StoreSerchManagerDelegate{
    func getStoreData(_ storeSerchManager : StoreSerchManager , store : [StoreModel])
}

struct StoreSerchManager {
    var delegate : StoreSerchManagerDelegate?
    
    let storeSerchURL = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?"
    let apiKey = "5cbfd5c0656e9755"
    
    //検索用URLを作成
    func fetchSearchStore(lat : CLLocationDegrees,lng:CLLocationDegrees) {
        let urlString = "\(storeSerchURL)key=\(apiKey)&lat=\(lat)&lng=\(lng)&rang=4&pet=1&count=30&format=json"
        print(urlString)
        //リクエストを実施
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
        //URLを作成
        if let url = URL(string: urlString){
            //URLSessionを作成
            let session = URLSession(configuration: .default)
            //sessionにタスクを与える
            let task = session.dataTask(with: url){data,response,error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    if let store = parseJson(storeData: safeData){
                        self.delegate?.getStoreData(self, store: store)
                    }
                    
                }
            }
            //タスクをスタートする
            task.resume()
            
        }
        
        func parseJson(storeData : Data) -> [StoreModel]? {
            do{
                let decoder = JSONDecoder()
                
                let decodedData = try decoder.decode(StoreData.self, from: storeData)
                
                var storeModel : [StoreModel] = []
                for shop in decodedData.results.shop {
                    storeModel.append(StoreModel(access: shop.access, address: shop.address, name: shop.name, genre: shop.genre.name, urls: shop.urls.pc))
                }
                return storeModel
                
                
            }catch{
                print(error)
                return nil
            }
            
        }
        
    }
}

