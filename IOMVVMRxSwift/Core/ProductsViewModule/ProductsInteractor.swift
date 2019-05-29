//
//  ProductsInteractor.swift
//  IOMVVMRxSwift
//
//  Created by D2k on 29/05/19.
//  Copyright © 2019 ajaybhanushali. All rights reserved.
//

import Foundation

import Foundation
import RxSwift

protocol ProductsInteractorProtocol {
    func getProducts(for tag: String) -> Observable<[SectionOfProducts]>
    func makeProductFav(at index: Int)
}

final class ProductsInteractor: ProductsInteractorProtocol {
    
    var sections = [
        SectionOfProducts(header: "fruits", items: [Product.init(name: "Mango", isLiked: false),
                                                    Product.init(name: "Lemon", isLiked: false),
                                                    Product.init(name: "Apple", isLiked: false)])
    ]
    
    func getProducts(for tag: String) -> Observable<[SectionOfProducts]> {
        return Observable.just(sections)
    }
    
    func makeProductFav(at index: Int) {
        sections[0].items[index].isLiked = !sections[0].items[index].isLiked
    }
}
