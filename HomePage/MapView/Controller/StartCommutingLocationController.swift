//
//  StartCommutingLocation.swift
//  HomePage
//
//  Created by Ricky on 17/06/22.
//

import Foundation

import UIKit
import CoreLocation

class StartCommutingLocationController: UIViewController{
    @IBOutlet weak var transportationCollectionView: UICollectionView!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var street: UILabel!
    let trasportList : [String] = ["car", "bicycle", "figure.walk", "train"]
    
    var locationCoordinate : CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transportationCollectionView.delegate = self
        transportationCollectionView.dataSource = self
        
        transportationCollectionView.register(UINib(nibName: "TransportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "transportCell")
    }
    @IBAction func didStartCommuting(_ sender: Any) {
    }
}


extension StartCommutingLocationController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trasportList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = transportationCollectionView.dequeueReusableCell(withReuseIdentifier: "transportCell", for: indexPath) as? TransportationCollectionViewCell else{
            fatalError()
        }
        cell.transportation.tag = indexPath.row
        cell.transportation.setBackgroundImage(UIImage(systemName: trasportList[indexPath.row]), for: .normal)
        
        return cell
    }
    
    
}
