//
//  ListBuilder.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import SwiftUI

class POIListBuilder {
    weak var rootViewController: UIViewController?

    func createPOIListModule() -> AnyView {
        let router = POIListRouter()
        let interactor = POIListInteractor()
        let presenter = POIListPresenter(interactor: interactor, router: router)
        interactor.setup(presenter: presenter) // interactor.presenter = presenter
        let store = POIListStore(presenter: presenter)
        presenter.setup(delegate: store) // presenter.delegate = delegate
        
        return AnyView(POIListView(store: store))
    }
}
