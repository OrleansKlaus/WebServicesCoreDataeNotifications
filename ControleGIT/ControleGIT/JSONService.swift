//
//  JSONService.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/25/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

/** A simple HTTP client for fetching JSON data. */
class JSONService
{
    /** Prepares a GET request for the specified URL. */
    class func GET(url: NSURL, user: String, password: String) -> SuccessHandler
    {
        let service = JSONService("GET", url, user, password)
        service.successHandler = SuccessHandler(service: service)
        return service.successHandler!
    }
    
    private init(_ name: String, _ url: NSURL, _ user: String, _ password: String)
    {
        self.name = name
        self.url  = url
        self.usuario = user
        self.senha = password
    }
    
    class SuccessHandler
    {
        func success(
            closure: (json: AnyObject) -> (), // Array or dictionary
            queue:   NSOperationQueue? ) // Background queue by default
            -> ErrorHandler
        {
            self.closure = closure
            self.queue = queue
            service.errorHandler = ErrorHandler(service: service)
            return service.errorHandler!
        }
        
        private init(service: JSONService)
        {
            self.service = service
            closure = { (_) in return }
        }
        
        private var
        closure: (json: AnyObject) -> (),
        queue:   NSOperationQueue?,
        service: JSONService
    }
    
    class ErrorHandler
    {
        func failure(
            closure: (statusCode: Int, error: NSError?) -> (),
            queue:   NSOperationQueue? ) // Background queue by default
        {
            self.closure = closure
            self.queue = queue
            service.execute()
        }
        
        private init(service: JSONService)
        {
            self.service = service
            closure = { (_,_) in return }
        }
        
        private var
        closure: (statusCode: Int, error: NSError?) -> (),
        queue:   NSOperationQueue?,
        service: JSONService
    }
    
    private func execute()
    {
        let loginString = NSString(format: "%@:%@", usuario, senha)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = name
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                [weak self]
                data, response, error in
                
                // Reference self strongly via `this`
                if let this = self
                {
                    var statusCode = 0
                    if let httpResponse = response as? NSHTTPURLResponse
                    {
                        statusCode = httpResponse.statusCode
                    }
                    
                    var json: AnyObject?, jsonError: NSError?
                    switch JSONObjectWithData(data)
                    {
                    case .Success(let res): json = res
                    case .Failure(let err): jsonError = err
                    }
                    this.handleResult(json, error ?? jsonError, statusCode)
                }
            }.resume()
    }
    
    private func handleResult(json: AnyObject?, _ error: NSError?, _ statusCode: Int)
    {
        if json != nil
        {
            let handler  = successHandler!
            let success  = { handler.closure(json: json!) }
            if let queue = handler.queue { queue.addOperationWithBlock(success) }
            else                         { success() }
        }
        else
        {
            let handler  = errorHandler!
            let failure  = { handler.closure(statusCode: statusCode, error: error) }
            if let queue = handler.queue { queue.addOperationWithBlock(failure) }
            else                         { failure() }
        }
        
        // Break the retain cycles keeping this object graph alive.
        errorHandler = nil
        successHandler = nil
    }
    
    private var
    errorHandler:   ErrorHandler?,
    successHandler: SuccessHandler?
    
    private let
    name: String,
    url:  NSURL,
    usuario: String,
    senha: String
}