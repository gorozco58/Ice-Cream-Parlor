//
//  ReceiptViewController.swift
//  TestApp
//
//  Created by Giovanny Orozco Loaiza on 22/03/20.
//  Copyright © 2020 Giovanny Orozco. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    @IBOutlet private weak var receiptTableView: UITableView!
    @IBOutlet private weak var startNewOrderButton: UIButton!
    
    private let viewModel: ReceiptViewModelProtocol
    private let dataSource = ReceiptDataSource()
    
    init(viewModel: ReceiptViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ReceiptViewController.self), bundle: nil)
        title = " "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptTableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        receiptTableView.estimatedRowHeight = 60
        receiptTableView.rowHeight = UITableView.automaticDimension
        receiptTableView.registerCell(ProductReceiptCell.self)
        receiptTableView.registerCell(FooterCell.self)
        receiptTableView.dataSource = dataSource
        receiptTableView.delegate = dataSource
        dataSource.delegate = viewModel
        startNewOrderButton.layer.borderWidth = 4
        startNewOrderButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func startNewOrderPressed() {
        let viewModel = ProductsViewModel()
        let viewController = ProductsViewController(viewModel: viewModel)
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
