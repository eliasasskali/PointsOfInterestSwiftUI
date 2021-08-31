//
//  ListProtocols.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import SwiftUI

/*protocol POIListViewInterface: AnyObject {
    
}*/

protocol POIListInteractorInterface: AnyObject {
    var presenter: POIListPresenterInterface? { get set }
    
    func fetchPOIList()
}

protocol POIListPresenterInterface: AnyObject {
    // var view: POIListViewInterface? { get set }
    var router: POIListRouterInterface? { get set }
    var interactor: POIListInteractorInterface? { get set }
        
    // POIListInteractor -> POIListPresenter
    func poiListFetched(poiList: [POITuple])
    func poiListFetchFailed(with errorMessage: String)
    
    // POIListPresenter -> POIListInteractor
    func fetchPOIList()
}

protocol POIListEntityInterface: AnyObject {
    
}

protocol POIListRouterInterface: AnyObject {
    
}
