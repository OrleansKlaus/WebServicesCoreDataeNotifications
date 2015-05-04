//
//  CoreData.swift
//  ControleGIT
//
//  Created by Orleans Klaus on 04/05/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import CoreData
import UIKit

public class CoreData {

func execCoreData() {
    
    // Get Core Data Context
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
    
    // Create the error pointer
    var err: NSErrorPointer = nil
    
    // Add Usuarios
    var user: User = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
    user.user = "OrleansKlaus"
    user.password = "123"
    //        user.photo = foto
    user.repositorio = Repositorio()
    
    // Add Repositorios
    var repositorio: Repositorio = NSEntityDescription.insertNewObjectForEntityForName("Repositorio", inManagedObjectContext: managedObjectContext) as! Repositorio
    repositorio.name = "iDicionario"
    repositorio.users = User()
    repositorio.tags = Tag()
    
    
    var tag: Tag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: managedObjectContext) as! Tag
    tag.titulo = "Bronze"
    tag.cor = "Bronze"
    //        tag.data = data
    tag.descricao = "Qualquer descricao"
    tag.repositorio = Repositorio()
    
    //        // Save Context
    //        managedObjectContext.save(err)
    //
    //        // Create the fetch request
    //        var fetchRequest = NSFetchRequest(entityName: "User")
    //
    //        // Fetch Usuarios
    //        var companies: NSArray! = managedObjectContext.executeFetchRequest(fetchRequest, error: err)
    //        for index in 0...companies.count-1 {
    //            let company = companies[index] as! User
    //            self.dataSource.addObject("User: \(user.user)")
    //        }
    //
    //        // Fetch Products
    //        fetchRequest = NSFetchRequest(entityName: "Product")
    //        var products: NSArray! = managedObjectContext.executeFetchRequest(fetchRequest, error: err)
    //        for index in 0...products.count-1 {
    //            let product = products[index] as! Product
    //            var company = product.company as! Company
    //            self.dataSource.addObject("Product: \(company.name) - \(product.name)")
    //        }
    }
}