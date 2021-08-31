//
//  ListRouter.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import SwiftUI

class POIListRouter: POIListRouterInterface {
    func makeDetailView(for poiId: Int) -> some View {
        return POIDetailBuilder.createPOIDetailModule(with: poiId)
    }
}
