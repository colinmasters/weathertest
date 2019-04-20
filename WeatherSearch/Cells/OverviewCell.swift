//
//  OverViewCell.swift
//  WeatherSearch
//
//  Created by Colin Masters on 02/04/2019.
//  Copyright © 2019 Colin Masters. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    
    @IBOutlet weak var timeDateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    private var iconBaseString = "https://openweathermap.org/img/w/"
    private var formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        timeDateLabel.text = ""
        iconImageView.image = nil
        minTempLabel.text = ""
        maxTempLabel.text = ""
    }
    
    func configure(with overview: Overview) {
        if let dt = overview.dt, let main = overview.main, let weather = overview.weather?.first {
            if let timeInterval = TimeInterval(exactly: dt) {
                let date = Date(timeIntervalSince1970: timeInterval)

                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "EEEE ha"
                formatter.amSymbol = "am"
                formatter.pmSymbol = "pm"
            
                timeDateLabel.text = formatter.string(from: date)
            }
            
            if let min = main.temp_min, let max = main.temp_max {
                minTempLabel.text = String(format: "%.0f°", min)
                maxTempLabel.text = String(format: "%.0f°", max)
            }
            
            if let icon = weather.icon {
                iconImageView.downloaded(from: "\(iconBaseString)\(icon).png")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
