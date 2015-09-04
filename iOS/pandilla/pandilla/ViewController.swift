//
//  ViewController.swift
//  pandilla
//
//  Created by DEV_SECM on 8/26/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController,SlideNavigationControllerDelegate{
    
    @IBOutlet var shadowView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pandilla F.C."
        
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: "mostrarJugadores", name: "mostrar_jugadores", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        shadowView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        
        var query = PFQuery(className:"Match")
        
        query.findObjectsInBackgroundWithBlock { ( results:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                NSLog("HOLA %@", results!);
                
            }
            
        }
        
    }
    
    func mostrarJugadores(){
        self.navigationController?.performSegueWithIdentifier("mostrar_jugadores", sender: self)
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
    

}

