//
//  ActionList.swift
//  HomePage
//
//  Created by Ricky on 15/06/22.
//

import Foundation
import UIKit

struct action{
    var name: String
    var desc: String
    var image: UIImage!
}



class Action{
    let actionArr: [action] = [
        action(
            name: "Call Center",
            desc: "Whenever you feel unsafe, call us.",
            image: UIImage(named: "CallCenter")!
        ),
        action(
            name: "Request Guardian",
            desc: "A guardian will come and protect you.",
            image: UIImage(named: "Guardian")!
        )
    ]
    
    
    let actionArrActive: [action] = [
        action(
            name: "Call Center",
            desc: "",
            image: UIImage(systemName: "phone.fill")!
        ),
        action(
            name: "Request Guardian",
            desc: "",
            image: UIImage(systemName: "figure.wave")!
        )
    ]
}
