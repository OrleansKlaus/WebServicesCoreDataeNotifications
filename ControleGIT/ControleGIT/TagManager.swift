//
//  TagManager.swift
//  ControleGIT
//
//  Created by Orleans Klaus on 30/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import CoreData
import UIKit

public class TagManager {
    static let shareInstance:TagManager = TagManager()
    static let entityName:String = "Tag"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var t = appDelegate.managedObjectContext
        return t!
        }()
    
    private init(){}
    
    func novaTag()->Tag
    {
        return NSEntityDescription.insertNewObjectForEntityForName(TagManager.entityName, inManagedObjectContext: managedContext) as! Tag
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        if let e = error{
            println("Não pode salvar. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarUsers()->Array<Tag>
    {
        let fetchRequest = NSFetchRequest(entityName: TagManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Tag] {
            return results
        } else {
            println("Não pode buscar registros. Error: \(error), \(error!.userInfo)")
        }
        return Array<Tag>()
    }
}

