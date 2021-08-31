//
//  POIDetailInteractor.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import RealmSwift

class POIDetailInteractor {
    weak var presenter: POIDetailPresenterInterface?
    private var pointOfInterest: PointOfInterest?
    
    func setup(presenter: POIDetailPresenter) {
        self.presenter = presenter
    }
    
    // Retrieve and Add PointOfInterestDB from url given id
    func getPOIInfo(forId id: Int) {
        let poiUrl = URL(string: "http://t21services.herokuapp.com/points/\(id)")!
        URLSession.shared.dataTask(with: poiUrl) { data, request, error in
            guard error == nil, let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let realm = try! Realm()
                if let poi = realm.object(ofType: PointOfInterestDB.self, forPrimaryKey: id) {
                    self.presenter?.poiFetched(poi: PointOfInterest(pointOfInterestDB: poi))
                } else {
                    let newPOI = PointOfInterestDB(value: json)
                    self.presenter?.poiFetched(poi: PointOfInterest(pointOfInterestDB: newPOI))
                    try! realm.write {
                        realm.add(newPOI)
                    }
                }
            } catch let error as NSError {
                self.presenter?.poiFetchFailed(error: error.description)
                print(error)
            }
        }.resume()
    }
}

extension POIDetailInteractor: POIDetailInteractorInterface {
    func fetchPOI(with id: Int) {
        self.getPOIInfo(forId: id)
    }
}
