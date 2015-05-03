//
//  ViewController.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 03/05/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    // teste view1
    
    var viewFoto = UIView()
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var indicador: UIActivityIndicatorView!
    @IBOutlet weak var signInLabel: UIButton!
    
    var height = UIScreen.mainScreen().bounds.size.height/2
    var width = UIScreen.mainScreen().bounds.size.width/2
    let searchUser: Search = Search.sharedInstance
    
    override func viewDidLoad() {
        
        viewFoto.layer.frame = CGRectMake(width - 75, height - 225, 150, 150)
        viewFoto.layer.cornerRadius = 75
        viewFoto.layer.backgroundColor =   UIColor(patternImage: UIImage(named: "git")!).CGColor
        viewFoto.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        view.addSubview(viewFoto)
        password.secureTextEntry = true
        
        let notificacao: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
        notificacao.addObserver(self, selector: "estaPronto:" , name: "resposta", object: nil)
        super.viewDidLoad()
        
        indicador.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
        
        signInLabel.hidden = true
        searchUser.user1 = userName.text
        searchUser.senha = password.text
        searchUser.buscaUsuario()
        indicador.hidden = false
        indicador.startAnimating()
        
        
    }
    
    
    func estaPronto(mensagem: NSNotification){
        
        if (searchUser.pronto == true){
            indicador.stopAnimating()
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.performSegueWithIdentifier("proximo", sender: self)
                self.userName.text = ""
                self.password.text = ""
                self.signInLabel.hidden = false
                self.indicador.stopAnimating()
                self.indicador.hidden = true
                
            }
        }else{
            AudioServicesPlaySystemSound(1352)
            
            ///
            userName.text = ""
            password.text = ""
            signInLabel.hidden = false
            indicador.stopAnimating()
            indicador.hidden = true
        }
        
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (userName.becomeFirstResponder()){
            userName.resignFirstResponder()
            
        }
        if ( password.becomeFirstResponder() && userName.resignFirstResponder()){
            password.resignFirstResponder()
            
        }
        
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        userName.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    
}
