//
//  ViewController.swift
//  ControleGIT
//
//  Created by Orleans Klaus on 27/04/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewFoto = UIView()
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var height = UIScreen.mainScreen().bounds.size.height/2
    var width = UIScreen.mainScreen().bounds.size.width/2
    

    override func viewDidLoad() {
        
        viewFoto.layer.frame = CGRectMake(width - 75, height - 225, 150, 150)
        viewFoto.layer.cornerRadius = 75
        viewFoto.layer.backgroundColor =   UIColor(patternImage: UIImage(named: "git")!).CGColor
        viewFoto.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        view.addSubview(viewFoto)
        password.secureTextEntry = true
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(sender: AnyObject) {
        self.performSegueWithIdentifier("proximo", sender: self)
    }
        
}

