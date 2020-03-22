import UIKit
import RxSwift

class ProductsViewController: UIViewController {

    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var orderButton: UIButton!
    
    private let dataSource = ProductsDataSource()
    private let viewModel: ProductsViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductsViewController.self), bundle: nil)
        title = "WELCOME"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    @IBAction func orderButtonPressed() {
        
    }
}

//MARK: - Private funcs
private extension ProductsViewController {
    
    func setupView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 90, right: 30)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        dataSource.delegate = viewModel
        productsCollectionView.dataSource = dataSource
        productsCollectionView.delegate = dataSource
        productsCollectionView.collectionViewLayout = flowLayout
        productsCollectionView.registerCell(ProductCell.self)
    }
    
    func bindViewModel() {
        viewModel
            .getProducts()
            .subscribe(onCompleted: { [productsCollectionView] in
                productsCollectionView?.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .itemsSelectedObservable
            .subscribe(onNext: { [orderButton] count in
                if count > 0 {
                    orderButton?.setTitle("ORDER \(count) ITEMS", for: .normal)
                } else {
                    orderButton?.setTitle("ORDER", for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
}
