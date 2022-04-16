//
//  ShopDetailViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/06.
//

import UIKit
import MapKit
import GoogleMobileAds

class StoreDetailViewController: UIViewController,UIScrollViewDelegate{
    
    var store: StoreModel?
    var mapUrlString: String?
    let showURLPhoto = ShowURLPhoto()
    let adManager = AdManager()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeGenreLabel: UILabel!
    @IBOutlet weak var storeCatchLabel: UILabel!
    @IBOutlet weak var storeAddressLabel: UILabel!
    @IBOutlet weak var storeAccessLabel: UILabel!
    
    @IBOutlet weak var searchSafariButton: UIButton!
    @IBOutlet weak var mapAppButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var fixedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        scrollView.delegate = self
        
        initMap()
        title = store?.name
        storeNameLabel.text = store?.name
        storeGenreLabel.text = store?.genre
        storeImageView.backgroundColor = .black
        storeImageView.image = showURLPhoto.showURLPhoto(photoUrl: store?.photo)
        storeCatchLabel.text = store?.`catch`
        storeAddressLabel.text = store?.address
        storeAccessLabel.text = store?.access
        searchSafariButton.titleLabel?.text = "webで検索する"
        mapAppButton.titleLabel?.text = "マップを起動する"

        if let id = adManager.adUnitID(key: K.banner) {
            bannerView.adUnitID = id
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
    }
    

    
    @IBAction func searchSafariPressed(_ sender: UIButton) {
        if let urlString = store?.urls{
            let url = URL(string: urlString)
            UIApplication.shared.open(url!)
        }
        
    }
    
    
    @IBAction func mapAppPressed(_ sender: UIButton) {
        if let lat = store?.lat, let lng = store?.lng{
            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!){
                mapUrlString = "comgooglemaps://?daddr=\(lat),\(lng)&directionsmode=walking"
            }else{
                mapUrlString = "http://maps.apple.com/?daddr=\(lat),\(lng)&dirflg=w"
            }
            
            if let urlString = mapUrlString{
                if let url = URL(string: urlString){
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}

//MARK: - MKMapViewDelegate

extension StoreDetailViewController: MKMapViewDelegate{
    func initMap(){
        let lat = (store?.lat)!
        let lng = (store?.lng)!
        let storeLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        //mapViewに緯度経度を設定
        mapView.setCenter(storeLocation, animated: true)

        //pinを設定
        let pin = MKPointAnnotation()
        pin.coordinate = storeLocation
        pin.title = store?.name
        mapView.addAnnotation(pin)

        //縮尺を設定
        var region = mapView.region
        region.center = storeLocation
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region, animated: true)
    }
}
