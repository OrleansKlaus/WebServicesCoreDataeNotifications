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
        println("lalala")
        return""
        }()
    
    
    var senha : String!
    
    var username: String!
    var password: String!
    var image: NSData!
    var urlImage = String()
    var pronto = Bool()
    
    ////////
    var repositorios: NSMutableArray!
    var arrayMackAux: NSDictionary!
    var arrayMackMobile: NSMutableArray!
    
    /////////////////
    var array: NSMutableArray!
    var userPull: NSDictionary!
    
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
    
    //
    
    var dataUser: NSDictionary!
    var dataRepo: NSArray!
    
    
    
    func buscaUsuario(){
        println(user1)
        println(senha)
        let url = NSURL(string: "https://api.github.com/search/users?q=\(user1)")
        JSONService.GET(url!, user: user1, password: senha).success(self.successOk, queue: nil) .failure(throwError, queue: NSOperationQueue.mainQueue())
    }
    
    func buscaRepositorios() -> NSMutableArray{
        let url = NSURL(string: "https://api.github.com/users/\(user1)/repos")
        JSONService.GET(url!, user: user1, password: senha).success(self.successRepoOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
        
        ////////coloca um break em baixo//////
        println(repositorios)
        
        return repositorios
    }
    
    func searchMackMobile() -> NSMutableArray {
        
        let todos = self.buscaRepositorios()
        
        var arrayOthersRepository = NSMutableArray()
        
        for var i = 0; i < todos.count; i++ {
            let urlRe = todos[i]["url"] as! String
            let url = NSURL(string: urlRe)
            JSONService.GET(url!, user: user1, password: senha).success(self.successMackOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
            
            if let parent: AnyObject = arrayMackAux["parent"] {
                if let owner: AnyObject = parent["owner"] {
                    if let login: AnyObject = owner["login"] {
                        if login as! String == "mackmobile" {
                            arrayMackMobile.addObject(arrayMackAux)
                        }
                    }
                }
            }
        }
        return arrayMackMobile
    }
    
    func searchBadges(nomeRepo: String) -> NSMutableArray{
        var page = 1
        var arrayCompleto = NSMutableArray()
        //var array = NSMutableArray()
        var tags = NSMutableArray()
        do {
            let url = NSURL(string: "https://api.github.com/repos/mackmobile/\(nomeRepo)/pulls?state=all&page=\(page)")
            JSONService.GET(url!, user: user1, password: senha).success(self.successTagOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
            repositorios.addObjectsFromArray(array as [AnyObject])
            page++
        } while array.count != 0
        
        var number = -1
        for var i=0; i < arrayCompleto.count; i++ {
            let userRepo = arrayCompleto[i]["user"] as! NSDictionary
            let login = userRepo["login"] as! String
            
            
            if login == user1 {
                number = arrayCompleto[i]["number"] as! Int
                break
            }
        }
        
        if number>0 {
            let url = NSURL(string: "https://api.github.com/repos/mackmobile/\(nomeRepo)/issues/\(number)")
            JSONService.GET(url!, user: user1, password: senha).success(self.successPullOk, queue: nil).failure(throwError, queue: NSOperationQueue.mainQueue())
            if let labels: AnyObject = userPull["labels"] as? NSArray {
                for var i=0; i < labels.count; i++ {
                    
                    ///Logica para as TAGS
                    
                }
            }
        }
        
        return tags
    }
    
    func successOk(json:AnyObject){
        self.dataUser = json as! NSDictionary
        println(dataUser)
        println("//////////////////////")
        
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
        
        ////////coloca um break em baixo
        println(repositorios)
    }
    
    func successMackOk(json:AnyObject){
        self.arrayMackAux = json as! NSDictionary
        println(arrayMackMobile)
    }
    
    func successTagOk(json:AnyObject){
        self.array = json as! NSMutableArray
        println(array)
    }
    
    func successPullOk(json:AnyObject){
        self.userPull = json as! NSDictionary
        println(userPull)
    }

}