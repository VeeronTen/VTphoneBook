//
//  HistoryUnit.swift
//  VTphoneBook
//
//  Created by Veeron Ten on 11/29/17.
//  Copyright © 2017 Veeron Ten. All rights reserved.
//

import UIKit

class HistoryUnit: NSObject {
    var date: Date
    var contact: Contact
    
    init(date: Date, contact: Contact){
        self.date = date
        self.contact = contact
    }
}
