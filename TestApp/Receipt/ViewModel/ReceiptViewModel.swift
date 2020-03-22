import Foundation

protocol ReceiptViewModelProtocol: ReceiptDataSourceDelegate {
    
}

class ReceiptViewModel: ReceiptViewModelProtocol {
    
    private let products: [Product]
    private let totalFormatted: String
    
    init(orderProducts: [Product]) {
        let total = orderProducts.reduce(0.0) { (current, product) in
            return current + product.price
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        
        totalFormatted = formatter.string(for: total) ?? ""
        products = orderProducts
    }
}

//MARK: - ReceiptDataSourceDelegate
extension ReceiptViewModel: ReceiptDataSourceDelegate {
    
    var data: [ReceiptCellType] {
        return [
            .empty,
            .products(products),
            .total("TOTAL", totalFormatted),
            .footer("THANK YOU")
        ]
    }
}
