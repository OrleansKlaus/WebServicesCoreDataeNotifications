//
//  repositorio.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation
import CoreData

class repositorio: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var tags: tag

}
