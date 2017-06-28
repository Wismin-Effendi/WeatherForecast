//
//  NoBorderTableViewCell.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/28/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class NoBorderTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        subviews.forEach { (view) in
            if type(of: view).description() == "_UITableViewCellSeparatorView" {
                view.isHidden = true
            }
        }
    }

}
