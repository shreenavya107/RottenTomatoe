//
//  MovieCell.swift
//  FinalRottenTomatoes
//
//  Created by Navya Nidhanapati on 9/14/14.
//  Copyright (c) 2014 Navya Nidhanapati. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the :view for the selected state
    }
    
        

    
    

}
