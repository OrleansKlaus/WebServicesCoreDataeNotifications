//
//  user.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {

    @NSManaged var password: String
    @NSManaged var photo: NSData
    @NSManaged var user: String
    @NSManaged var repositorio: Repositorio

}
