//
//  POIDetailBuilder.swift
//  PointsOfInterestSUI
//
//  Created by elias on 26/8/21.
//

import Foundation
import SwiftUI

class POIDetailBuilder {
    class func createPOIDetailModule(with id: Int) -> AnyView {
        let router = POIDetailRouter()
        let interactor = POIDetailInteractor()
        let presenter = POIDetailPresenter(interactor: interactor, router: router)
        interactor.setup(presenter: presenter)
        let store = POIDetailStore(presenter: presenter)
        presenter.setup(delegate: store)
        
        return AnyView(POIDetailView(store: store, pointOfInterestId: id))
    }
}
