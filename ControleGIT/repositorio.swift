//
//  repositorio.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation
import CoreData

@objc(repositorio)
class repositorio: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var tags: Tag
    
// Orleans inclui a extensao de Tag
    func addTag(tag:Tag) {
        var tags = self.mutableSetValueForKey("tags")
        tags.addObject(tag)
    }

}
