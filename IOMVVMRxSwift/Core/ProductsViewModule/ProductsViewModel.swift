//
//  ProductsViewModel.swift
//  IOMVVMRxSwift
//
//  Created by Ajay Bhanushali on 24/05/19.
//  Copyright © 2019 ajaybhanushali. All rights reserved.
//

import RxSwift
import RxCocoa

class ProductsViewModel: ViewModelProtocol {
    struct Input {
        let ready: AnyObserver<Void>
        let tappedLike: AnyObserver<Void>
    }
    
    struct Output {
        let products: Driver<[SectionOfProducts]>
    }
    
    let input: Input
    let output: Output
    
    private let disposeBag = DisposeBag()
    private let readySubject = PublishSubject<Void>()
    private let tappedLikeSubject = PublishSubject<Void>()
    private let likedIndexSubject = PublishSubject<IndexPath>()
    
    init(_ interator: ProductsInteractorProtocol) {
        
        input = Input(ready: readySubject.asObserver(),
                      tappedLike: tappedLikeSubject.asObserver())
        
        let products = interator.getProducts(for: "")
            .asDriver(onErrorJustReturn: [])

        tappedLikeSubject.subscribe ({_ in
            
        }).disposed(by: disposeBag)
        
        output = Output(products: products)
    }
}
