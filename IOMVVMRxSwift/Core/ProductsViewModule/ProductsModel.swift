//
//  ProductsModel.swift
//  IOMVVMRxSwift
//
//  Created by Ajay Bhanushali on 24/05/19.
//  Copyright © 2019 ajaybhanushali. All rights reserved.
//

import Foundation
import RxDataSources

struct Product {
    var name: String
    var isLiked: Bool
}

struct SectionOfProducts {
    var header: String
    var items: [Item]
}
extension SectionOfProducts: SectionModelType {
    typealias Item = Product
    
    init(original: SectionOfProducts, items: [Item]) {
        self = original
        self.items = items
    }
}
