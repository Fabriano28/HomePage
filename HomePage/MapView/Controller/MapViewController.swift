//
//  ViewController.swift
//  MapsLocation
//
//  Created by Ricky on 14/06/22.
//

import Foundation
import CoreLocation
import MapKit
import UIKit
class MapViewController: UIViewController{

    @IBOutlet weak var map: MKMapView!
    
    let manager =  CLLocationManager()
    var destination =  CLLocationCoordinate2D()
    
//    lazy var locationSearchVC = UIStoryboard(name: "LocationSearchView", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchViewController")
    lazy var locationSearchVC = UIStoryboard(name: "LocationSearchView", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchView")
    lazy var startCommutingLocationVC = UIStoryboard(name: "StartCommutingLocation", bundle: nil).instantiateViewController(withIdentifier: "StartCommutingLocation")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetController = locationSearchVC.sheetPresentationController {
                sheetController.detents = [.medium(), .large()]
            }
        map.mapType = .standard
 
        self.present(locationSearchVC, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate =  self
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationSegue"{
            let vc = segue.destination as? LocationSearchViewController
            vc?.delegate = self
        }
    }
    
    
}



extension MapViewController: LocationSearchViewControllerProtocol{
    func ReceiveCoordinateDestination(coordinate: CLLocationCoordinate2D) {
        
        pinLocation(coordinate: coordinate)
        if let sheetController = startCommutingLocationVC.sheetPresentationController {
                sheetController.detents = [.medium(), .large()]
            }
        let data = startCommutingLocationVC as? StartCommutingLocationController
        data?.locationCoordinate = coordinate
        self.present(startCommutingLocationVC, animated: true)
    }
    
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        pinLocation(coordinate: coordinate)
    }
    func pinLocation(coordinate: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
    
        print("data : \(coordinate)")
        pin.coordinate =  coordinate
        map.addAnnotation(pin)
    }
    
}


