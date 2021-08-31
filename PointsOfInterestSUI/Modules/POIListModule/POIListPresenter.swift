//
//  ListPresenter.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import SwiftUI

class POIListPresenter {
    var router: POIListRouterInterface?
    var interactor: POIListInteractorInterface?
    private weak var delegate: POIListStore?
    
    init(interactor: POIListInteractorInterface, router: POIListRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func setup(delegate: POIListStore) {
        self.delegate = delegate
        self.fetchPOIList()
    }
}

extension POIListPresenter: POIListPresenterInterface {
    func fetchPOIList() {
        interactor?.fetchPOIList()
    }
    
    func poiListFetched(poiList: [POITuple]) {
        print("PoiListFetched")
        delegate?.poiResultsFetched(poiList: poiList)
    }
    
    func poiListFetchFailed(with error: String) {
        delegate?.poiResultsFetchFailed(error: error)
    }
    
}
