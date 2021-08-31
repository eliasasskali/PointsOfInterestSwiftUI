//
//  PointOfInterest.swift
//  PointsOfInterestSUI
//
//  Created by elias on 13/8/21.
//

struct PointOfInterest: Identifiable {
    let id: Int
    let title: String
    let geocoordinates: String
    let desc: String?
    let email: String?
    let phone: String?
    let transport: String?
    let address: String?
}

// MARK: Convenience init
extension PointOfInterest {
  init(pointOfInterestDB: PointOfInterestDB) {
    id = pointOfInterestDB.id
    title = pointOfInterestDB.title
    geocoordinates = pointOfInterestDB.geocoordinates
    desc = pointOfInterestDB.desc
    email = pointOfInterestDB.email
    phone = pointOfInterestDB.phone
    transport = pointOfInterestDB.transport
    address = pointOfInterestDB.address
  }
}
