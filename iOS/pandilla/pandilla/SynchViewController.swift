//
//  SynchViewController.swift
//  pandilla
//
//  Created by Angel Alberto Rueda Mejía on 19/09/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit
import Parse

class SynchViewController: UIViewController {

    @IBOutlet var mensaje:UILabel?
    @IBOutlet var reload:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var mustContinue = true
            var query = PFQuery(className:"Match")
            query.addDescendingOrder("Fecha")
            query.whereKey("Fecha", lessThan: NSDate())
            
            var error = NSErrorPointer()
            let results:[AnyObject]? = query.findObjects(error)
            
            if error == nil{
                
            }else{
                mustContinue = false
            }
            
            var queryNext = PFQuery(className:"Match")
            queryNext.addAscendingOrder("Fecha")
            queryNext.whereKey("Fecha", greaterThan: NSDate())
            let nextMatch:PFObject? = queryNext.getFirstObject(error)
            
            if error == nil{
                var pandillaData:PandillaData = PandillaData.sharedInstance()
                pandillaData.nextMatch = nextMatch
            }else{
                mustContinue = false
            }
            
            if mustContinue {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("start_app", sender: self)
                })
            }else{
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.mensaje?.text = "Error al descargar la información"
                    self.reload?.hidden = false
                })
                
                
            }
            
        })
        /*
        
        
        query.findObjectsInBackgroundWithBlock { ( results:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
            }
            
        }
        
        
        queryNext.getFirstObjectInBackgroundWithBlock { (results:PFObject?, error) -> Void in
            
            if error == nil {
                
                results?.save()
                
                
            }
        }
        */
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let leftMenu:LeftViewController = LeftViewController(nibName: "LeftViewController", bundle: nil)
        
        SlideNavigationController.sharedInstance().rightMenu = nil
        SlideNavigationController.sharedInstance().leftMenu = leftMenu
        
    }


}
