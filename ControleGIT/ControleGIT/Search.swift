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
    var data: NSDictionary!
    
    func searchUser(){
        let loginString = NSString(format: "%@:%@", user, senha)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let url = NSURL(string: "https://api.github.com/search/users?q=\(user)")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let urlConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        urlConnection?.start()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.jsonData?.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.jsonData = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.data = NSJSONSerialization.JSONObjectWithData(self.jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        println(data)
    }
    
}
