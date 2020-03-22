//
//  ProductReceiptCell.swift
//  TestApp
//
//  Created by Giovanny Orozco Loaiza on 22/03/20.
//  Copyright © 2020 Giovanny Orozco. All rights reserved.
//

import UIKit

enum ReceiptCellStyle {
    case normal
    case bold
}

class ProductReceiptCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func setupView(with name: String, and price: String, style: ReceiptCellStyle) {
        productNameLabel.text = name
        productPriceLabel.text = price
        
        switch style {
        case .normal:
            productPriceLabel.textColor = .lightGray
        case .bold:
            productPriceLabel.textColor = .darkGray
        }
    }
}
