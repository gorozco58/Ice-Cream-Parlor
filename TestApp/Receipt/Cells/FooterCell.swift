//
//  FooterCell.swift
//  TestApp
//
//  Created by Giovanny Orozco Loaiza on 22/03/20.
//  Copyright © 2020 Giovanny Orozco. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    func setupView(with title: String) {
        titleLabel.text = title
    }
}
