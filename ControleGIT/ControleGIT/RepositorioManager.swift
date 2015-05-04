//
//  RepositorioManager.swift
//  ControleGIT
//
//  Created by Orleans Klaus on 30/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import CoreData
import UIKit

public class RepositorioManager {
    static let sharedInstance:RepositorioManager = RepositorioManager()
    static let entityName:String = "Repositorio"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var r = appDelegate.managedObjectContext
        return r!
    }()
    
    private init(){}
    
    func novoRepositorio()->Repositorio
    {
        return NSEntityDescription.insertNewObjectForEntityForName(RepositorioManager.entityName, inManagedObjectContext: managedContext) as! Repositorio
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        if let e = error{
            println("Não pode salvar. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarRepositorios()->Array<Repositorio>
    {
        let fetchRequest = NSFetchRequest(entityName: RepositorioManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Repositorio] {
            return results
        } else {
            println("Não pode buscar registros. Error: \(error), \(error!.userInfo)")
        }
        return Array<Repositorio>()
    }
    
}
