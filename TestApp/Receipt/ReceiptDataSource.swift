import UIKit

enum ReceiptCellType {
    case empty
    case products([ProductRepresentable])
    case total(String, String)
    case footer(String)
}

protocol ReceiptDataSourceDelegate: class {
    var data: [ReceiptCellType] { get }
}

class ReceiptDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: ReceiptDataSourceDelegate?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellType = delegate?.data[section] else {
            return 0
        }
        
        switch cellType {
        case .empty:
            return 1
        case .products(let products):
            return products.count
        case .total:
            return 1
        case .footer:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = delegate?.data[indexPath.section] else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .empty:
            let cell: ProductReceiptCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: "", and: "", style: .normal)
            return cell
            
        case .products(let products):
            let product = products[indexPath.row]
            let title = product.numberSelected > 1 ? "\(product.name) (\(product.numberSelected))" : product.name
            let cell: ProductReceiptCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: title, and: product.priceFormatted, style: .normal)
            return cell
            
        case .total(let title, let totalPrice):
            let cell: ProductReceiptCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: title, and: totalPrice, style: .bold)
            return cell
            
        case .footer(let text):
            let cell: FooterCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: text)
            return cell
        }
    }
}
