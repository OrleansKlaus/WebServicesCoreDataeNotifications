//
//  TableViewController.swift
//  ControleGIT
//
//  Created by Gabriel Alberto de Jesus Preto on 03/05/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//


import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate, NSURLConnectionDelegate {
    
    var viewFoto = UIView()
    var height = UIScreen.mainScreen().bounds.size.height/2
    var width = UIScreen.mainScreen().bounds.size.width/2
    var arrayProjetos = ["iDicionario", "minichallenge-1", "minichallenge -2"]
    var usuario: String!
    var senha: String!
    var userData: NSDictionary!
    var avatar: UIImage!
    var arrayRepositorios: NSMutableArray!
    var arrayMackmobile: NSMutableArray!
    
    let searchUser: Search = Search.sharedInstance
    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelNome.text = searchUser.username
        
        var data = NSData(contentsOfURL: NSURL(string:searchUser.urlImage)!)
        avatar = UIImage(data: data!)
        self.createImage()
        
        arrayMackmobile = searchUser.searchMackMobile()

        println(arrayMackmobile)
        
    }
    
    func createImage(){
        let imageView = UIImageView(image: avatar)
        imageView.frame = CGRectMake(width - 75, height - 240, 150, 150)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 70
        view.addSubview(imageView)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMackmobile.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = self.arrayMackmobile[indexPath.row].valueForKey("parent")?.valueForKey("name") as? String
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositórios do Mackmobile"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    
    @IBAction func Sair(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let celula = sender as? UITableViewCell
        {
            
            let notificacao: NSNotificationCenter = NSNotificationCenter.defaultCenter()
            
            notificacao.addObserver(segue.destinationViewController, selector: "criarTitulo:" , name: "novoNome", object: nil)
            
            
            var nome = celula.textLabel?.text
            let mensagem: NSDictionary = NSDictionary(object: nome!, forKey: "mensagem")
            notificacao.postNotificationName("novoNome", object: self, userInfo: mensagem as [NSObject: AnyObject])
            
            println(" celula \(celula.textLabel?.text)")
        }
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}