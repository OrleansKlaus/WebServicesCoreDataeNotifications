//
//  Search.swift
//  ControleGIT
//
//  Created by Matheus Amancio Seixeiro on 5/3/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation

class Search: NSObject{
    
    lazy var user1 :String = {
        println("lalala")
        return""
        }()
    
    
    var senha : String!
    
    //   var user1 = "gabrielalbertojesuspreto"
    //    var senha = "gabriel1234"
    var username: String!
    var password: String!
    var image: NSData!
    var urlImage = String()
    var pronto = Bool()
    
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
}