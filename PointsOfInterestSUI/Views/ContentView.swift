//
//  ContentView.swift
//  PointsOfInterestSUI
//
//  Created by elias on 13/8/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: PointOfInterestStore
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText)
                    .padding([.top])
                List(store.pointsOfInterestResults
                            .filter({
                                    searchText.isEmpty
                                        ? true
                                        : $0.title.contains(searchText)}))
                { poi in
                    
                    NavigationLink(
                        destination: PointOfInterestDetailView(pointOfInterest: poi)) {
                        HStack {
                            Image(systemName: "location")
                            Text(poi.title)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Points Of Interest"), displayMode: .inline)
                .onAppear {
                    store.loadData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
