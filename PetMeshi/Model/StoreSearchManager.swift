//
//  StoreSearchManager.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import Foundation
import CoreLocation

protocol StoreSerchManagerDelegate{
    func getStoreData(_ storeSerchManager: StoreSerchManager, store: [StoreModel], resultsNum: Int)
}

struct StoreSerchManager {
    var delegate : StoreSerchManagerDelegate?
    
    let storeSerchURL = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?"
    let apiKey = "5cbfd5c0656e9755"
    
    //検索用URLを作成
    func fetchSearchStore(lat : CLLocationDegrees,lng:CLLocationDegrees) {
        let urlString = "\(storeSerchURL)key=\(apiKey)&lat=\(lat)&lng=\(lng)&rang=4&pet=1&count=30&format=json"
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
                    let result = parseJson(storeData: safeData)
                    if let safeStore = result.store{
                        self.delegate?.getStoreData(self, store: safeStore, resultsNum: result.resultsNum)
                    }
                    
                }
            }
            //タスクをスタートする
            task.resume()
            
        }
        
        func parseJson(storeData : Data) -> (store: [StoreModel]?, resultsNum: Int) {
            do{
                let decoder = JSONDecoder()
                
                let decodedData = try decoder.decode(StoreData.self, from: storeData)
                
                var storeModel : [StoreModel] = []
                let resultsNum : Int = decodedData.results.results_available
                for shop in decodedData.results.shop {
                    storeModel.append(StoreModel(access: shop.access, address: shop.address, name: shop.name, genre: shop.genre.name, urls: shop.urls.pc, photo: shop.photo.pc.l, catch: shop.catch))
                }
                return (storeModel, resultsNum)
                
                
            }catch{
                print(error)
                return (nil,0)
            }
            
        }
        
    }
}

