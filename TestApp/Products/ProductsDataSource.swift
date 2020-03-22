import UIKit

protocol ProductsDataSourceDelegate: class {
    var data: [ProductRepresentable] { get }
    
    func updateProductSelected(at index: Int) -> ProductRepresentable
}

class ProductsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: ProductsDataSourceDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueCell(at: indexPath)
        
        if let product = delegate?.data[indexPath.row] {
            cell.setupView(with: product)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate,
            let cell: ProductCell = collectionView.cellForItem(at: indexPath) as? ProductCell else {
                return
        }
        
        let updatedProduct = delegate.updateProductSelected(at: indexPath.row)
        cell.setupView(with: updatedProduct)
    }
}
