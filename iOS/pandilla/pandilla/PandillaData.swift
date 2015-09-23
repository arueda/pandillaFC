//
//  PandillaData.swift
//  pandilla
//
//  Created by Angel Alberto Rueda Mejía on 19/09/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit
import Parse

class PandillaData: NSObject {
    
    static var instance:PandillaData? = nil
    var nextMatch:PFObject? = nil
    
    static func sharedInstance() -> PandillaData{
        
        if PandillaData.instance == nil {
            
            PandillaData.instance = PandillaData()
            
        }
        
        return PandillaData.instance!
        
    }
    
    func getNextMatch() -> PFObject{
        return nextMatch!
    }
    
    
    
    
   
}
