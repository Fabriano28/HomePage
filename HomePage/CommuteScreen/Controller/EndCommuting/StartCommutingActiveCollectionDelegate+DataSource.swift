//
//  ActionActiveCollectionDelegate+DataSource.swift
//  HomePage
//
//  Created by Ricky on 16/06/22.
//

import Foundation
import UIKit
extension StartCommutingActiveController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actionList.actionArrActive.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = actionCollectionView.dequeueReusableCell(withReuseIdentifier: "actionActiveCell", for: indexPath)as? StartCommutingActiveCollectionViewCell else{
            fatalError()
        }
        cell.dataDisplayed = actionList.actionArrActive[indexPath.row]
        return cell
    }
}
