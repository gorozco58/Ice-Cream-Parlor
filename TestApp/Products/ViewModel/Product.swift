import UIKit

class Product: Codable {
    let name1: String
    let name2: String
    let price: String
    let hexColor: String
    let type: String
    var numberSelected: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case name1
        case name2
        case price
        case hexColor = "bg_color"
        case type
    }
}

//MARK: - ProductRepresentable
extension Product: ProductRepresentable {
    var image: UIImage? {
        return UIImage(named: type)
    }
    
    var backgroundColor: UIColor {
        return .hex(hexColor)
    }
    
    var name: String {
        return "\(name1) \(name2)"
    }
}

protocol ProductRepresentable {
    var image: UIImage? { get }
    var backgroundColor: UIColor { get }
    var name: String { get }
    var price: String { get }
    var numberSelected: Int { get }
}
