//
//  ViewController.swift
//  HomePage
//
//  Created by Ricky on 14/06/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    

    @IBOutlet weak var segmentedView: UISegmentedControl!
    @IBOutlet weak var journetView: UIView!
    @IBOutlet weak var guardingRingView: UIView!
    @IBOutlet weak var journeyActiveView: UIView!
    
    //segmented
    var counter = 0
    var viewList: [UIView] = []
    
    //location
    let manager =  CLLocationManager()
    var locationCoordinate =  CLLocationCoordinate2D()
    var destination : CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewList = [journetView,guardingRingView]
        
        title = "Journey"
        
        segmentedView.selectedSegmentIndex =  counter
        setTitleSegmented()
        setGesture()
        
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer){
       
        counter = 1 - counter
        self.view.bringSubviewToFront(viewList[counter])
        segmentedView.selectedSegmentIndex = counter
        
    }
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        
        self.view.bringSubviewToFront(viewList[sender.selectedSegmentIndex])
        counter = segmentedView.selectedSegmentIndex
    }
    
    
    func setTitleSegmented(){
        
        segmentedView.setTitle("Journey", forSegmentAt: 0)
        segmentedView.setTitle("Guarding Ring", forSegmentAt: 1)
    }
    
    func setGesture(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture: )))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture: )))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        self.view.bringSubviewToFront(journetView)
    }
    
    
    //start Commuting
    func selectedStartCommuting() {
        
        self.view.bringSubviewToFront(journeyActiveView)
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    
    @IBAction func didSelectedEndCommuting(_ sender: Any) {
        self.view.bringSubviewToFront(journetView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate =  self
        
    }
    
    @IBAction func unwindCommuteScreen( _ seg: UIStoryboardSegue) {
        guard let data = seg.source as? StartCommutingLocationController else{
            fatalError()
        }
        self.destination = data.locationCoordinate
        self.view.bringSubviewToFront(journeyActiveView)
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    func render(_ location: CLLocation){
        locationCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: locationCoordinate, span: span)
    }
}
