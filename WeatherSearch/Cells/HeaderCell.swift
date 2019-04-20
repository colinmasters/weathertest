//
//  HeaderCell.swift
//  WeatherSearch
//
//  Created by Colin Masters on 03/04/2019.
//  Copyright © 2019 Colin Masters. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
