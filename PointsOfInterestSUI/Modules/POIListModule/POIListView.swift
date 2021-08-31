//
//  POIListView.swift
//  PointsOfInterestSUI
//
//  Created by elias on 27/8/21.
//

import SwiftUI

struct POIListView: View {
    @ObservedObject var store: POIListStore
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBarView(text: $searchText)
                .padding([.top])
                .zIndex(1.0)
            List {
                ForEach(store.pointsOfInterestResults
                            .filter({searchText.isEmpty
                                        ? true
                                        : $0.title.contains(searchText)}), id: \.id) { poi in
                    self.store.linkBuilder(for: poi.id) {
                        POIRow(title: poi.title)
                    }
                }
            }
            .navigationBarTitle(Text("Points Of Interest"), displayMode: .inline)
        }
    }
}

struct POIRow: View {
    var title: String
    var body: some View {
        HStack {
            Image(systemName: "location")
            Text(title)
        }
    }
}

struct POIListView_Previews: PreviewProvider {
    static var previews: some View {
        POIListView(store: POIListStore(presenter: POIListPresenter(interactor: POIListInteractor(), router: POIListRouter())))
    }
}
