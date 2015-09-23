//
//  ViewController.swift
//  pandilla
//
//  Created by DEV_SECM on 8/26/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController,SlideNavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var shadowView:UIView!
    @IBOutlet var table:UITableView?
    
    @IBOutlet var contenedorView:UIView!
    @IBOutlet var bannerView:UIImageView!
    
    @IBOutlet var fechaLabel:UILabel!
    @IBOutlet var sedeLabel:UILabel!
    @IBOutlet var diaLabel:UILabel!
    
    @IBOutlet var localLabel:UILabel!
    @IBOutlet var visitanteLabel:UILabel!
    @IBOutlet var localImgView:UIImageView!
    @IBOutlet var visitanteImgView:UIImageView!
    
    
    enum ESTADOS{
        case  ENCUENTROS
        case  JUGADORES
        case  ESTADISTICAS
        case  GALERIA
    }
    
    
    var state:ESTADOS = ESTADOS.ENCUENTROS
    
    
    var encuentrosPasados:NSArray = []
    private let reuseIdentifier = "EncuentroCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pandilla F.C."
        
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: "mostrarJugadores", name: "mostrar_jugadores", object: nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        shadowView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        
        var query = PFQuery(className:"Match")
        query.addDescendingOrder("Fecha")
        query.whereKey("Fecha", lessThan: NSDate())

        query.findObjectsInBackgroundWithBlock { ( results:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                self.encuentrosPasados = results!
                self.table?.reloadData()
                
            }
            
        }
        
        var queryToday = PFQuery(className:"Match")
        queryToday.addDescendingOrder("Fecha")
        queryToday.whereKey("Fecha", equalTo: NSDate())
        
        queryToday.findObjectsInBackgroundWithBlock { ( results:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                NSLog("%@",results!);
                
            }
            
        }
        
        
        var pandillaData:PandillaData = PandillaData.instance!
        var nextMatch:PFObject = pandillaData.nextMatch!
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "MMM-dd '-' h:mm a"
        
        let fecha:NSDate = nextMatch.objectForKey("Fecha") as! NSDate
        self.fechaLabel.text = dateFormatter.stringFromDate(fecha)
        let esLocal: Bool = nextMatch.objectForKey("Local")!.boolValue
        let rivalStr:NSString = nextMatch.objectForKey("Rival") as! String
        
        if( esLocal ){
            self.localLabel.text = "PANDILLA FC"
            self.localImgView.image = UIImage(named: "pandillaNewLogo")
            
            self.visitanteLabel.text = rivalStr as String
            self.visitanteImgView.image = UIImage(named: "logoRivalSiguiente")
        }else{
            
            self.visitanteLabel.text = "PANDILLA FC"
            self.visitanteImgView.image = UIImage(named: "pandillaNewLogo")
            
            self.localLabel.text = rivalStr as String
            self.localImgView.image = UIImage(named: "logoRivalSiguiente")
        }
        
    }
    
    func mostrarJugadores(){
        if( self.state != ESTADOS.JUGADORES ){
            self.navigationController?.popToRootViewControllerAnimated(false)
            self.navigationController?.performSegueWithIdentifier("mostrar_jugadores", sender: self)
            self.state = ESTADOS.JUGADORES
        }else{
            
        }
    }
    
    func mostrarHome(){
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    func mostrarGaleria(){
        //self.navigationController?.popToRootViewControllerAnimated(false)
        self.navigationController?.performSegueWithIdentifier("mostrar_galeria", sender: self)
        
    }
    
    func mostrarEstadisticas(){
        //self.navigationController?.popToRootViewControllerAnimated(false)
        self.navigationController?.performSegueWithIdentifier("mostrar_estadisticas", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true;
    }
    
    func slideNavigationControllerShouldDisplayRightMenu() -> Bool {
        return false;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: MatchTableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? MatchTableViewCell
        
        if (cell == nil) {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier) as? MatchTableViewCell
        }
        
        let encuentro:PFObject = encuentrosPasados[indexPath.row] as! PFObject
        
        let esLocal: Bool = encuentro.objectForKey("Local")!.boolValue
        let rival = encuentro.objectForKey("Rival") as! String
        let GC = encuentro.objectForKey("GC")!.integerValue
        let GF = encuentro.objectForKey("GF")!.integerValue
        
        
        
        if (esLocal){
            cell?.nombreLocal?.text = "PANDILLA F.C."
            cell?.imagenLocal?.image = UIImage(named: "logoPandilla")
            cell?.imagenVisitante?.image = UIImage(named: "logoRivalPasado")
            
            let marcadorText = NSString(format: "%i - %i", GF,GC)
            cell?.marcador?.text = marcadorText as String
        }else{
            cell?.nombreLocal?.text = rival
            cell?.imagenVisitante?.image = UIImage(named: "logoPandilla")
            cell?.imagenLocal?.image = UIImage(named: "logoRivalPasado")
            let marcadorText = NSString(format: "%i - %i", GC,GF)
            cell?.marcador?.text = marcadorText as String
        }
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return encuentrosPasados.count
    }
    

}

