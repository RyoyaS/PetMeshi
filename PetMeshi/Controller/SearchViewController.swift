//
//  ViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/02/28.
//

import UIKit
import CoreLocation
import GoogleMobileAds

class SearchViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!

    let locationManager = CLLocationManager()
    var Latitude: CLLocationDegrees?
    var Longitude: CLLocationDegrees?
    var storeSearchManager = StoreSerchManager()
    var storeInfo : [StoreModel] = []
    var resultNum = 0
    let adManager = AdManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.contentHorizontalAlignment = .fill
        searchButton.contentVerticalAlignment = .fill
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        storeSearchManager.delegate = self

        if let id = adManager.adUnitID(key: K.banner) {
            bannerView.adUnitID = id
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }

    }

    @IBAction func creditButtonPressed(_ sender: UIButton) {
        let url = URL(string: "https://webservice.recruit.co.jp/")
        if let safeURL = url{
            if UIApplication.shared.canOpenURL(safeURL){
                UIApplication.shared.open(safeURL)
            }
        }
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
                storeListVC.resultNum = self.resultNum
                storeListVC.userLocation = CLLocation(latitude: self.Latitude!, longitude: self.Longitude!)
            }
        }

        func getStoreData(_ storeSerchManager: StoreSerchManager, store: [StoreModel], resultsNum resultNum: Int){
            storeInfo = store
            self.resultNum = resultNum
            DispatchQueue.main.async {
                if self.resultNum != 0{
                    self.performSegue(withIdentifier: K.storeListSegue, sender: self)
                }else{
                    self.performSegue(withIdentifier: K.notFoundSegue, sender: self)
                }
            }
        }
    }

//MARK: - NavigationController

extension SearchViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

}
