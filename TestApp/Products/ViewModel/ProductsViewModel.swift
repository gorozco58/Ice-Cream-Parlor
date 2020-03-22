import Foundation
import RxSwift
import Alamofire

protocol ProductsViewModelProtocol: ProductsDataSourceDelegate {
    
    var itemsSelectedObservable: Observable<Int> { get }
    
    func getProducts() -> Completable
    func getCartProducts() -> [Product]
}

class ProductsViewModel {
    
    private var products: [Product] = []
    private let itemsSubject = PublishSubject<Int>()
}

//MARK: - ProductsViewModelProtocol
extension ProductsViewModel: ProductsViewModelProtocol {
    
    var itemsSelectedObservable: Observable<Int> {
        return itemsSubject.asObservable()
    }
    
    func getProducts() -> Completable {
        return Completable.create { completable in
            AF.request("http://gl-endpoint.herokuapp.com/products").responseJSON {
                switch $0.result {
                case .success(let data):
                    do {
                        let products: [Product] = try JSONDecoder.model(with: data)
                        self.products = products
                        completable(.completed)
                    } catch {
                        completable(.error(error))
                    }
                case .failure(let error):
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func getCartProducts() -> [Product] {
        return products.filter { $0.numberSelected > 0 }
    }
}

//MARK: - ProductsDataSourceDelegate
extension ProductsViewModel: ProductsDataSourceDelegate {
    
    var data: [ProductRepresentable] {
        return products
    }
    
    func updateProductSelected(at index: Int) -> ProductRepresentable {
        let product = products[index]
        switch product.numberSelected {
        case 0,1:
            product.numberSelected += 1
        default:
            product.numberSelected = 0
        }
            
        let productsCount = products.reduce(0) { (current, product) in
            return current + product.numberSelected
        }
        
        itemsSubject.onNext(productsCount)
        
        return product
    }
}
