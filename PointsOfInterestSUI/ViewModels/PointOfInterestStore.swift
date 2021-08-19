//
//  PointOfInterestStore.swift
//  PointsOfInterestSUI
//
//  Created by elias on 13/8/21.
//

import Foundation
import RealmSwift

final class PointOfInterestStore: ObservableObject {
    @Published var pointsOfInterestResults: [PointOfInterest] = try! Realm().objects(PointOfInterestDB.self)
        .sorted(byKeyPath: "title", ascending: true)
        .map(PointOfInterest.init)
}

extension PointOfInterestStore {
    // Load data from url
    func loadData() {
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
                    if let id = (poi["id"]! as? NSString)?.intValue {
                        self.getPOIInfo(forId: Int(id), group: group)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
        
        group.notify(queue: .main) {
            self.pointsOfInterestResults = try! Realm().objects(PointOfInterestDB.self)
                .sorted(byKeyPath: "title", ascending: true)
                .map(PointOfInterest.init)
        }
    }
    
    // Retrieve and Add PointOfInterestDB from url given id
    func getPOIInfo(forId id: Int, group: DispatchGroup) {
        let poiUrl = URL(string: "http://t21services.herokuapp.com/points/\(id)")!
        group.enter()
        URLSession.shared.dataTask(with: poiUrl) { data, request, error in
            defer { group.leave() }
            guard error == nil, let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let realm = try! Realm()
                if (realm.object(ofType: PointOfInterestDB.self, forPrimaryKey: id) == nil) {
                    //print(json)
                    let newPOI = PointOfInterestDB(value: json)
                    try! realm.write {
                        realm.add(newPOI)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
    }
}
