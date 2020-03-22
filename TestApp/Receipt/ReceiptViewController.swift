//
//  ReceiptViewController.swift
//  TestApp
//
//  Created by Giovanny Orozco Loaiza on 22/03/20.
//  Copyright © 2020 Giovanny Orozco. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    private let dataSource = ProductsDataSource()
    private let viewModel: ProductsViewModelProtocol
    
    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductsViewController.self), bundle: nil)
        title = " "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    

}
