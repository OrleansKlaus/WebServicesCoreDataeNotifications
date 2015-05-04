//
//  UserManagerx.swift
//  ControleGIT
//
//  Created by Orleans Klaus on 30/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import CoreData
import UIKit

public class UserManager {
    static let shareInstance:UserManager = UserManager()
    static let entityName:String = "User"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var u = appDelegate.managedObjectContext
        return u!
        }()
    // Add Usuarios
    var user: User = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
    user.user = "OrleansKlaus"
    user.password = "123"
    //        user.photo = foto
    user.repositorio = Repositorio()
    
    private init(){}
    
    func novoUser()->user
    {
        return NSEntityDescription.insertNewObjectForEntityForName(UserManager.entityName, inManagedObjectContext: managedContext) as! user
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        if let e = error{
            println("Não pode salvar. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarUsers()->Array<User>
    {
        let fetchRequest = NSFetchRequest(entityName: UserManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [User] {
            return results
        } else {
            println("Não pode buscar registros. Error: \(error), \(error!.userInfo)")
        }
        return Array<User>()
    }
}

