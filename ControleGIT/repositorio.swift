//
//  repositorio.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation
import CoreData

@objc(Repositorio)
class Repositorio: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var tags: Tag
    @NSManaged var users: User
    
// Orleans inclui a extensao de Tag
    func addTag(tags:Tag) {
        var tags = self.mutableSetValueForKey("tags")
        tags.addObject(tags)
    }
    func addUser(users:User) {
        var users = self.mutableSetValueForKey("users")
        users.addObject(users)
    }

}
