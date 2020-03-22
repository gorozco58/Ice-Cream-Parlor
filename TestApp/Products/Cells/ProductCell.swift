//
//  ProductCell.swift
//  TestApp
//
//  Created by Giovanny Orozco Loaiza on 22/03/20.
//  Copyright © 2020 Giovanny Orozco. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet private weak var imageBackgroundView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.height / 2
    }
    
    func setupView(with product: ProductRepresentable) {
        imageBackgroundView.backgroundColor = product.backgroundColor
        productImageView.image = product.image
        titleLabel.text = product.name
        priceLabel.text = product.priceFormatted
        quantityLabel.text = "\(product.numberSelected)"
        
        if product.numberSelected == 0 {
            layer.borderWidth = 1
            layer.borderColor = UIColor.borderGray.cgColor
            quantityLabel.isHidden = true
        } else {
            layer.borderWidth = 3
            layer.borderColor = UIColor.mainBlue.cgColor
            quantityLabel.isHidden = false
        }
    }
}
