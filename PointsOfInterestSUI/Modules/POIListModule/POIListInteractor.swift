//
//  ListInteractor.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import RealmSwift

class POIListInteractor {
    weak var presenter: POIListPresenterInterface?
    private var pointsOfInterestResults: [POITuple]? = []
    
    func setup(presenter: POIListPresenter) {
        self.presenter = presenter
    }
    
    // Load data from url
    func loadData() {
        self.pointsOfInterestResults = []
        let group = DispatchGroup()
        let url = URL(string: "http://t21services.herokuapp.com/points")!
        group.enter()
        URLSession.shared.dataTask(with: url) { data, request, error in
            guard error == nil, let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let list = json["list"] as? [[String:Any]] ?? []
                defer { group.leave() }
                for poi in list {
                    if let id = (poi["id"]! as? NSString)?.intValue,
                       let title = (poi["title"] as? String) {
                        let poiTuple = POITuple(id: Int(id), title: title)
                        self.pointsOfInterestResults?.append(poiTuple)
                    }
                }
            } catch let error as NSError {
                self.presenter?.poiListFetchFailed(with: error.description)
                print(error)
            }
        }.resume()
        
        group.notify(queue: .main) {
            print(self.pointsOfInterestResults?.count ?? 0)
            self.presenter?.poiListFetched(poiList: self.pointsOfInterestResults ?? [])
        }
    }
}

extension POIListInteractor: POIListInteractorInterface {
    func fetchPOIList() {
        self.loadData()
    }
}
