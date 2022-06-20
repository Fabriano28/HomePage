//
//  ResultViewController.swift
//  Tabbar
//
//  Created by Ricky on 10/06/22.
//

import Foundation
import UIKit
import CoreLocation


protocol LocationSearchViewControllerProtocol: AnyObject{
    func ReceiveCoordinateDestination(coordinate : CLLocationCoordinate2D)
}



class LocationSearchViewController: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!

    weak var delegate: LocationSearchViewControllerProtocol?
    let searchBar = UISearchController(searchResultsController: nil)
    private var places: [Place] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        navigationItem.searchController = searchBar
        searchBar.searchResultsUpdater = self
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        resultsTableView.register(UINib(nibName: "LocationSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "locationSearchCell")
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultsTableView.frame = view.bounds
    }


    public func update(with Places: [Place]){
        resultsTableView.isHidden = false
        self.places = Places
        resultsTableView.reloadData()
    }

}


extension LocationSearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {

        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else{


            return
        }
        
        GooglePlacesManager.shared.findPlaces(query: query){
            result in switch result {
                case .success(let places):


                    DispatchQueue.main.async {
                        self.update(with: places)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}


extension LocationSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationSearchCell", for: indexPath)as? LocationSearchTableViewCell else{
            fatalError()
        }
        cell.resultCell.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        tableView.isHidden = true
        let place = places[indexPath.row]
        searchBar.searchBar.resignFirstResponder()
        GooglePlacesManager.shared.resolveLocation(for: place) {[weak self] result in
            switch result{
            case .success(let coordinate):
                
                self?.dismiss(animated: true){
                    
                    self?.delegate?.ReceiveCoordinateDestination(coordinate: coordinate)
                }
                    
                

            case .failure(let error):
                print(error)
            }
        }
    }

}
