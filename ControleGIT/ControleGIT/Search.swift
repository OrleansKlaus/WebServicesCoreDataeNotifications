//
//  Search.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 03/05/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation

class Search: NSObject{
    
    lazy var user1 :String = {
        return""
        }()
    
    
    var senha : String!
    
    var username: String!
    var password: String!
    var image: NSData!
    var urlImage = String()
    var pronto = Bool()
    
    var repositorios: NSMutableArray!
    var arrayMackAux: NSDictionary!
    var arrayMackMobile: NSMutableArray!
    
    var array: NSArray!
    var userPull: NSDictionary!
    var tags : NSMutableArray!

    private override init(){
        super.init()
    }
    
    
    class var sharedInstance : Search{
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : Search? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Search()
        }
        return Static.instance!
    }
    
    
    var dataUser: NSDictionary!
    var dataRepo: NSArray!
    
    func buscaUsuario(){
        let url = NSURL(string: "https://api.github.com/search/users?q=\(user1)")
        JSONService.GET(url!, user: user1, password: senha).success(self.successOk, queue: nil) .failure(throwError, queue: NSOperationQueue.mainQueue())
    }
    
    func buscaRepositorios() -> NSMutableArray{
        let url = NSURL(string: "https://api.github.com/users/\(user1)/repos")
        JSONService.GET(url!, user: user1, password: senha).success(self.successRepoOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
        
        while repositorios==nil{}
        return repositorios
    }
    
    func searchMackMobile() -> NSMutableArray {
        
        let todos = self.buscaRepositorios()
        arrayMackMobile = NSMutableArray()
        for var i = 0; i < todos.count; i++ {
            let url = NSURL(string: todos[i]["url"] as! String)
            JSONService.GET(url!, user: user1, password: senha).success(self.successMackOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
            
            while arrayMackAux == nil{}
            
            if let parent: AnyObject = arrayMackAux["parent"] {
                if let owner: AnyObject = parent["owner"] {
                    if let login: AnyObject = owner["login"] {
                        if login as! String == "mackmobile" {
                            arrayMackMobile.addObject(arrayMackAux)
                        }
                    }
                }
            }
            arrayMackAux = nil;
        }
        return arrayMackMobile
    }
    
    func buscarTags(nomeRepo: String) -> NSMutableArray{
        var page = 0
        var arrayCompleto = NSMutableArray()
        do {
            let url = NSURL(string: "https://api.github.com/repos/mackmobile/\(nomeRepo)/pulls?state=all&page=\(page)")
            JSONService.GET(url!, user: user1, password: senha).success(self.successTagOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
            
            while array == nil{}
            for(var i=0; i<array.count; i++){
                arrayCompleto.addObject(array[i])
            }
            array = nil
            page++
        } while page < 3
        
        var number = -1
        for var i=0; i < arrayCompleto.count; i++ {
            let userRepo = arrayCompleto[i]["user"] as! NSDictionary
            let login = userRepo["login"] as! String
            
            if (login.lowercaseString == user1.lowercaseString) {
                number = arrayCompleto[i]["number"] as! Int
                break
            }
        }
        
        if (number>0) {
            let url = NSURL(string: "https://api.github.com/repos/mackmobile/\(nomeRepo)/issues/\(number)")
            JSONService.GET(url!, user: user1, password: senha).success(self.successPullOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
            
            while userPull == nil{}
            
            if let labels: AnyObject = (userPull["labels"] as? NSMutableArray){
                for var i=0; i < labels.count; i++ {
                    tags = labels as! NSMutableArray
                }
            }else {
                tags = NSMutableArray()
            }
             
        }
        
        return tags
    }
    
    func successOk(json:AnyObject){
        self.dataUser = json as! NSDictionary
        
        if(dataUser.valueForKey("documentation_url") as? String != "https://developer.github.com/v3"){
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                self.username = self.dataUser.valueForKey("items")!.valueForKey("login")![0] as! String
                println(self.username)
                self.urlImage = self.dataUser.valueForKey("items")!.valueForKey("avatar_url")![0] as! String
                println(self.dataUser.valueForKey("items")!.valueForKey("avatar_url")![0] as! String)
                self.pronto = true
                let notificacao: NSNotificationCenter = NSNotificationCenter.defaultCenter()
                notificacao.postNotificationName("resposta", object: self)}
        }
        else{
            NSOperationQueue.mainQueue().addOperationWithBlock {
                println("errooooo")
                self.pronto = false
                let notificacao: NSNotificationCenter = NSNotificationCenter.defaultCenter()
                notificacao.postNotificationName("resposta", object: self)}}
    }
    
    func throwError(statusCode: Int, error: NSError?){
        println("erro")
    }
    
    func successRepoOk(json:AnyObject){
        self.repositorios = json as! NSMutableArray
    }
    
    func successMackOk(json:AnyObject){
        self.arrayMackAux = json as! NSDictionary
    }
    
    func successTagOk(json:AnyObject){
        self.array = json as! NSArray
    }
    
    func successPullOk(json:AnyObject){
        self.userPull = json as! NSDictionary
    }

}