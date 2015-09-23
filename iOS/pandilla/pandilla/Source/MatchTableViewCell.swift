//
//  MatchTableViewCell.swift
//  pandilla
//
//  Created by Angel Alberto Rueda Mejía on 12/09/15.
//  Copyright (c) 2015 Angel Rueda. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet var imagenLocal:UIImageView?
    @IBOutlet var imagenVisitante:UIImageView?
    
    @IBOutlet var nombreLocal:UILabel?
    @IBOutlet var nombreVisitante:UILabel?
    @IBOutlet var marcador:UILabel?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
