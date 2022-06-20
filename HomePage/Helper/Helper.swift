//
//  UIViewExtension.swift
//  HomePage
//
//  Created by Ricky on 15/06/22.
//

import Foundation
import UIKit


extension UIView{
    func createBorder(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
}

extension UICollectionView{
    func actionCellRegister(nibName: String, identifier: String){
        //start commute
        let nibCell = UINib(nibName: nibName, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: identifier)
        
    }
}

extension UIButton{
    func Border(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
}
