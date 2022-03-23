//
//  ViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var Latitude: CLLocationDegrees?
    var Longitude: CLLocationDegrees?
    var locInfo = ""
    var storeSearchManager = StoreSerchManager()
    var storeInfo : [StoreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        storeSearchManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShopList"{
            let shopListVC = segue.destination as! ShopListViewController
            shopListVC.shopList = storeInfo
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension SearchViewController:  CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else {return}
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            
            if let error = error {
                print("reverseGeocodeLocation Failed: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?[0] {
                //緯度経度
                self.Latitude = loc.coordinate.latitude
                self.Longitude = loc.coordinate.longitude
                
                //現在地情報
                self.locInfo = self.locInfo + "Country: \(placemark.country ?? "")\n"
                self.locInfo = self.locInfo + "State/Province: \(placemark.administrativeArea ?? "")\n"
                self.locInfo = self.locInfo + "City: \(placemark.locality ?? "")\n"
                self.locInfo = self.locInfo + "PostalCode: \(placemark.postalCode ?? "")\n"
                self.locInfo = self.locInfo + "Name: \(placemark.name ?? "")"
                
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

//MARK: - StoreSerchManagerDelegate

extension SearchViewController: StoreSerchManagerDelegate{
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        //nilでなければ緯度経度から検索する
        if Latitude != nil && Longitude != nil{
            storeSearchManager.fetchSearchStore(lat: Latitude!, lng: Longitude!)
        }else{
            self.performSegue(withIdentifier: "goToNotFoundStore", sender: self)
        }
    }
    
    func getStoreData(_ storeSerchManager : StoreSerchManager , store : [StoreModel]){
        storeInfo = store
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goToShopList", sender: self)
        }
    }
}
