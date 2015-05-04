//
//  tag.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation
import CoreData

@objc(Tag)
class Tag: NSManagedObject {

    @NSManaged var cor: String
    @NSManaged var data: NSDate
    @NSManaged var descricao: String
    @NSManaged var titulo: String
    @NSManaged var repositorio: Repositorio
}
