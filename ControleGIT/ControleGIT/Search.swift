//
//  Search.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation

class Search: NSObject{
    var user = "gabrielalbertojesuspreto"
    var senha = "gabriel1234"
    var username: String!
    var password: String!
    var image: NSData!
    
    private override init(){}
    static let sharedInstance = Search();
    
    
    var dataUser: NSDictionary!
    var dataRepo: NSArray!
    
    
    
    func buscaUsuario(){
        let url = NSURL(string: "https://api.github.com/search/users?q=gabrielalbertojesuspreto")
        JSONService.GET(url!, user: user, password: senha).success(self.successOk, queue: nil) .failure(throwError, queue: NSOperationQueue.mainQueue())
    }
    
    func successOk(json:AnyObject){
        self.dataUser = json as! NSDictionary
        println(dataUser)
        println("//////////////////////")
        username = dataUser.valueForKey("items")!.valueForKey("login")![0] as! String
        println(username)
        println(dataUser.valueForKey("items")!.valueForKey("avatar_url")![0] as! String)
    }
    
    func throwError(statusCode: Int, error: NSError?){
        println("erro")
    }
}