//
//  TableViewController.swift
//  ControleGIT
//
//  Created by Matheus Amancio Seixeiro on 4/28/15.
//  Copyright (c) 2015 Orleans Klaus. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var viewFoto = UIView()
    var height = UIScreen.mainScreen().bounds.size.height/2
    var width = UIScreen.mainScreen().bounds.size.width/2
    var arrayProjetos = ["iDicionario", "minichallenge-1", "minichallenge -2"]
    
    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        self.createView()
    }
    
    func createView(){
        viewFoto.layer.frame = CGRectMake(width - 75, height - 225, 150, 150)
        viewFoto.layer.cornerRadius = 75
        viewFoto.layer.backgroundColor = UIColor.blackColor().CGColor
        view.addSubview(viewFoto)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayProjetos.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = self.arrayProjetos[indexPath.row]
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Mackmobile"
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    
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
