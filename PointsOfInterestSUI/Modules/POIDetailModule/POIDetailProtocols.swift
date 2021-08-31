//
//  POIDetailProtocols.swift
//  PointsOfInterestSUI
//
//  Created by elias on 26/8/21.
//

import Foundation

/*protocol POIDetailViewInterface: AnyObject {
    
}*/

protocol POIDetailInteractorInterface: AnyObject {
    var presenter: POIDetailPresenterInterface? { get set }
    
    func fetchPOI(with id: Int)
}

protocol POIDetailPresenterInterface: AnyObject {
    // var view: POIDetailViewInterface? { get set }
    var interactor: POIDetailInteractorInterface? { get set }
    var router: POIDetailRouterInterface? { get set }
    
    // Presenter -> Interactor
    func fetchPOI(with id: Int)
    
    // Interactor -> Presenter
    func poiFetched(poi: PointOfInterest)
    func poiFetchFailed(error: String)
}

protocol POIDetailEntityInterface: AnyObject {
    
}

protocol POIDetailRouterInterface: AnyObject {
    
}
