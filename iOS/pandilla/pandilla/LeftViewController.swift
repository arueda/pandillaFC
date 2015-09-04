//
//  LeftViewController.swift
//  pandilla
//
//  Created by DEV_SECM on 8/31/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mostrarJugadores(){
        
        NSNotificationCenter.defaultCenter().postNotificationName("mostrar_jugadores", object: nil)
        
    }
    
    @IBAction func mostrarPartidos(){
        
        NSNotificationCenter.defaultCenter().postNotificationName("mostrar_partidos", object: nil)
        
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
