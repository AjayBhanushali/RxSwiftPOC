//
//  ProductsVC.swift
//  IOMVVMRxSwift
//
//  Created by Ajay Bhanushali on 24/05/19.
//  Copyright © 2019 ajaybhanushali. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ProductsVC: UIViewController, ControllerType {
    typealias ViewModelType = ProductsViewModel
    
    // MARK:- Outlets
    @IBOutlet weak var tableViewProducts: UITableView!
    
    // MARK:- Class Properties
    var viewModel:  ProductsViewModel!
    var dataSource: RxTableViewSectionedReloadDataSource<SectionOfProducts>?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        configure(with: viewModel)
    }
    
    private func prepareUI() {
        tableViewProducts.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    func configure(with viewModel: ViewModelType) {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfProducts>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
                cell.labelProductName.text = item.name
                cell.indexPathSubject.onNext(indexPath)
                cell.buttonLike.rx.tap.asObservable()
                    .subscribe(viewModel.input.tappedLike)
                    .disposed(by: cell.disposeBag)
                cell.buttonLike.setTitle(item.isLiked.description, for: .normal)
                return cell
        })
        self.dataSource = dataSource
        
        viewModel.output.products.asObservable()
            .bind(to: tableViewProducts.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension ProductsVC: UITableViewDelegate {
    
}

extension ProductsVC {
    static func create(with viewModel: ViewModelType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsVC
        controller.viewModel = viewModel
        return controller
    }
}



// TODO:- Move it to Interactor
//    func getUsers() -> Observable<[SectionModel]> {
//        return Observable.create { (observer) -> Disposable in
//            let users = [Product.init(name: "Mango", isLiked: false), Product.init(name: "Apple", isLiked: false), Product.init(name: "Lime", isLiked: false)]
//            let section = [SectionModel(model: "", items: users)]
//            observer.onNext(section)
//            observer.onCompleted()
//            return AnonymousDisposable{}
//        }
//    }
