//
//  ViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!
    let locationManager = CLLocationManager()
    var Latitude: CLLocationDegrees?
    var Longitude: CLLocationDegrees?
    var locInfo = ""
    var storeSearchManager = StoreSerchManager()
    var storeInfo : [StoreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appNameLabel.text = K.appName
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        storeSearchManager.delegate = self
    }
    
}

//MARK: - CLLocationManagerDelegate

extension SearchViewController:  CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last{
            //緯度経度
            self.Latitude = loc.coordinate.latitude
            self.Longitude = loc.coordinate.longitude
        }
        //        現在情報を表示する場合のメモ
        //        CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
        //
        //            if let error = error {
        //                print("reverseGeocodeLocation Failed: \(error.localizedDescription)")
        //                return
        //            }
        //
        //            if let placemark = placemarks?[0] {
        //                //現在地情報
        //                self.locInfo = self.locInfo + "Country: \(placemark.country ?? "")\n"
        //                self.locInfo = self.locInfo + "State/Province: \(placemark.administrativeArea ?? "")\n"
        //                self.locInfo = self.locInfo + "City: \(placemark.locality ?? "")\n"
        //                self.locInfo = self.locInfo + "PostalCode: \(placemark.postalCode ?? "")\n"
        //                self.locInfo = self.locInfo + "Name: \(placemark.name ?? "")"
        //            }
        //        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

//MARK: - StoreSerchManagerDelegate

extension SearchViewController: StoreSerchManagerDelegate{
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        //nilでなければ緯度経度から検索する
        if let safeLat = Latitude, let safeLng = Longitude{
            storeSearchManager.fetchSearchStore(lat: safeLat, lng: safeLng)
        }else{
            self.performSegue(withIdentifier: K.notFoundSegue, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.storeListSegue{
            let storeListVC = segue.destination as! StoreListViewController
            storeListVC.storeList = storeInfo
        }
    }
    
    func getStoreData(_ storeSerchManager: StoreSerchManager , store: [StoreModel]){
        storeInfo = store
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.storeListSegue, sender: self)
        }
    }
}
