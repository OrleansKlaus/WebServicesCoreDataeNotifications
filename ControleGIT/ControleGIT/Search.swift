//
//  Search.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 29/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import Foundation

class Search: NSObject, NSURLConnectionDataDelegate {

    //singleton
    static let sharedInstance = Search()
    override init(){}
    //
    
    var user = "iTeste"
    var senha = "iteste1234"
    var search = "gabrielalbertojesuspreto"
    
    var jsonData: NSMutableData!
    var data: NSMutableArray!
    
    func buscaUsuario(){
        let loginString = NSString(format: "%@:%@", user, senha)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        //let url = NSURL(string: "https://api.github.com/search/users?q=\(search)/repos")
        let url = NSURL(string: "​https://api.github.com/user/\(search)/repos")
        
        JSONService.GET(url!, user: user, password: senha) .success(self.teste, queue: nil) .failure(testeError, queue: NSOperationQueue.mainQueue())
    }
    
    func teste(json:AnyObject){
        self.data = json as! NSMutableArray
        println(data)
    }
    
    func testeError(statusCode: Int, error: NSError?){
        println("erro")
    }
    
}
