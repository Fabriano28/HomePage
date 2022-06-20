//
//  GuardingRingController.swift
//  HomePage
//
//  Created by Ricky on 15/06/22.
//

import Foundation
import Contacts
import ContactsUI
import UIKit

class GuardingRingController: UIViewController, CNContactPickerDelegate{
    
    @IBOutlet weak var layerOne: UIView!
    @IBOutlet weak var layerTwo: UIView!
    @IBOutlet weak var layerThree: UIView!
    @IBOutlet weak var contactPerson1: UIButton!
    @IBOutlet weak var contactPerson2: UIButton!
    @IBOutlet weak var contactPerson3: UIButton!
    @IBOutlet weak var contactPerson4: UIButton!
    @IBOutlet weak var contactPerson5: UIButton!
    
    var contactPersonButton : [UIButton] = []
    var image: UIImage?
    var name: String = ""
    var number: String = ""
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        layerBorder()
        setUpButton()
        
    }
    func setUpButton(){
        contactPersonButton = [contactPerson1, contactPerson2, contactPerson3, contactPerson4 , contactPerson5]
        
        for i in 0..<contactPersonButton.count{
            
            contactPersonButton[i].tag = i + 1
            contactPersonButton[i].addTarget(self, action: #selector(didSelectedContact), for: .touchUpInside)
        }
    }
    
    func layerBorder(){
        layerOne.createBorder()
        layerTwo.createBorder()
        layerThree.createBorder()
    }
    
    @objc func didSelectedContact(sender: UIButton){
        
        counter = sender.tag
        let vc = CNContactPickerViewController()
        
        vc.delegate =  self
        present(vc, animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        name = contact.givenName

//        image = UIImage(data: contact.imageData!)
        image = UIImage(named: "CallCenter")
        contactPersonButton[counter].setImage(image, for: .normal)
  
    }
}

//extension CNContactPickerViewController{
//    open override func viewDidAppear(_ animated: Bool) {
//        self
//    }
//}
