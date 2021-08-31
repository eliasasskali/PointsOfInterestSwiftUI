//
//  POIDetailStore.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation

class POIDetailStore: ObservableObject {
    private var presenter: POIDetailPresenterInterface
    @Published var pointOfInterest: PointOfInterest
    
    init(presenter: POIDetailPresenterInterface) {
        self.presenter = presenter
        self.pointOfInterest = PointOfInterest(id: 0, title: "", geocoordinates: "0.0,0.0", desc: "", email: "", phone: "", transport: "", address: "")
    }
    
    func poiFetched(poi: PointOfInterest) {
        DispatchQueue.main.async {
            self.pointOfInterest = poi
        }
    }
    
    func poiFetchFailed(error: String) {
        print(error)
    }
    
    func fetchPOI(with id: Int) {
        presenter.fetchPOI(with: id)
    }
}
