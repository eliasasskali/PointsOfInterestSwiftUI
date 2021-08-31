//
//  ListStore.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import Foundation
import SwiftUI

class POIListStore: ObservableObject {
    private var presenter: POIListPresenterInterface
    @Published var pointsOfInterestResults: [POITuple]
    
    init(presenter: POIListPresenterInterface) {
        self.presenter = presenter
        self.pointsOfInterestResults = []
    }
    
    func poiResultsFetched(poiList: [POITuple]) {
        print("Store -> view")
        DispatchQueue.main.async {
            self.pointsOfInterestResults = poiList
        }
    }
    
    func poiResultsFetchFailed(error: String) {
        print(error)
    }
    
    func fetchPOIList() {
        presenter.fetchPOIList()
    }
    
    func linkBuilder<Content: View>(
        for poiId: Int,
        @ViewBuilder content: () -> Content
      ) -> some View {
        NavigationLink(
            destination: POIDetailBuilder.createPOIDetailModule(with: poiId)) {
              content()
        }
    }
}
