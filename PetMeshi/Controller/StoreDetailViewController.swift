//
//  ShopDetailViewController.swift
//  PetMeshi
//
//  Created by 鈴木涼也 on 2022/03/06.
//

import UIKit

class StoreDetailViewController: UIViewController{
    
    var store: StoreModel?
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeGenreLabel: UILabel!
    @IBOutlet weak var storeCatchLabel: UILabel!
    @IBOutlet weak var searchSafariButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = store?.name
        storeNameLabel.text = store?.name
        storeGenreLabel.text = store?.genre
        storeImageView.backgroundColor = .black
        storeImageView.image = showPhoto(photoUrl: store?.photo)
        storeCatchLabel.text = store?.`catch`
        searchSafariButton.titleLabel?.text = "webで検索する"
        
    }
    
    //店画像設定関数
    func showPhoto(photoUrl: String?) -> UIImage{
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
    
    //線を引く関数
    func drawline(){
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 0, y: 180))
        line.addLine(to:CGPoint(x: 300, y: 180))
        line.close()
        UIColor.gray.setStroke()
        line.lineWidth = 2.0
        line.stroke()
    }
    
    @IBAction func searchSafariPressed(_ sender: UIButton) {
        if let urlString = store?.urls{
            let url = URL(string: urlString)
            UIApplication.shared.open(url!)
        }
        
    }
}
