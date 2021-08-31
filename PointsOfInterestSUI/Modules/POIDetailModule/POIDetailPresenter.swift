//
//  POIDetailPresenter.swift
//  PointsOfInterestSUI
//
//  Created by elias on 26/8/21.
//

import Foundation

class POIDetailPresenter {
    var router: POIDetailRouterInterface?
    var interactor: POIDetailInteractorInterface?
    private weak var delegate: POIDetailStore?
    
    init(interactor: POIDetailInteractorInterface, router: POIDetailRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func setup(delegate: POIDetailStore) {
        self.delegate = delegate
    }
}

extension POIDetailPresenter: POIDetailPresenterInterface {
    func fetchPOI(with id: Int) {
        interactor?.fetchPOI(with: id)
    }
    
    func poiFetched(poi: PointOfInterest) {
        delegate?.poiFetched(poi: poi)
    }
    
    func poiFetchFailed(error: String) {
        delegate?.poiFetchFailed(error: error)
    }
    
    
}
