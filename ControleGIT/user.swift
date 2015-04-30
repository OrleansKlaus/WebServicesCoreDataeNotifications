//
//  user.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation
import CoreData

@objc(user)
class user: NSManagedObject {

    @NSManaged var password: String
    @NSManaged var photo: NSData
    @NSManaged var user: String
    @NSManaged var repositorios: repositorio

}
