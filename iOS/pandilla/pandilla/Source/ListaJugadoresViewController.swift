//
//  ListaJugadoresViewController.swift
//  pandilla
//
//  Created by DEV_SECM on 9/2/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit
import Parse

class ListaJugadoresViewController: UIViewController,SlideNavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView:UICollectionView?;
    private let reuseIdentifier = "JugadorCell"
    var jugadores:NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jugadores"
        
        var query = PFQuery(className:"Jugador")
        
        query.findObjectsInBackgroundWithBlock { ( results:[AnyObject]?, error:NSError?) -> Void in
            
            
            if error == nil {
            
                self.jugadores = results!
                self.collectionView?.reloadData()
            
            }
            
        }
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jugadores.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! JugadorCollectionViewCell
        //cell.backgroundColor = UIColor.blackColor()
        
        
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = cell.view!.bounds
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.blackColor().CGColor]
        gradient.startPoint = CGPointMake(0.5, 0.0);
        gradient.endPoint = CGPointMake(0.5, 1.0);
        
        cell.view!.layer.insertSublayer(gradient, atIndex: 0)
        //cell.view!.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.5)
        
        let jugador:PFObject = jugadores[indexPath.row] as! PFObject
        
        let camiseta = jugador.objectForKey("numero")?.integerValue
        let apodo:NSString = jugador.objectForKey("Apodo") as! NSString
        cell.camiseta?.text = NSString(format: "Camiseta %i", camiseta!) as String
        cell.nombre?.text = apodo as String
        
        
        let camisetaString = NSString(format: "%i", jugador.objectForKey("numero")!.integerValue!);
        cell.avatar?.image = UIImage(named: camisetaString as String)
        
        NSLog("%@", jugador)
        //cell.view!.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        // Configure the cell
        return cell
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
