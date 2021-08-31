//
//  POIDetailView.swift
//  PointsOfInterestSUI
//
//  Created by elias on 30/8/21.
//

import SwiftUI

struct POIDetailView: View {
    @ObservedObject var store: POIDetailStore
    let pointOfInterestId: Int
    
    var body: some View {
        ScrollView {
            MapView(pointOfInterest: store.pointOfInterest)
                .frame(minWidth: 100, idealWidth: .infinity, maxWidth: .infinity, minHeight: 200, idealHeight: 250, maxHeight: 300, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(store.pointOfInterest.title)
                    .font(.title)
                Text(store.pointOfInterest.geocoordinates)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Divider()
                
                if let description = store.pointOfInterest.desc {
                    Text(description)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.top, .bottom])
                        .multilineTextAlignment(.leading)
                    Divider()
                }
                
                if let email = store.pointOfInterest.email {
                    RowView(iconName: "mail", info: email)
                }
                if let phone = store.pointOfInterest.phone {
                    RowView(iconName: "phone", info: phone)
                }
                if let transport = store.pointOfInterest.transport {
                    RowView(iconName: "car", info: transport)
                }
                if let address = store.pointOfInterest.address {
                    RowView(iconName: "location", info: address)
                }
            }
            .padding()
        }
    }
}

struct RowView: View {
    var iconName: String
    var info: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: iconName)
                .accentColor(.primary)
                .imageScale(.medium)
                .font(.system(size: 30, weight: .light))
                .frame(width: 40.0, height: 40.0)
            Text(info)
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
        }
        .padding(4)
        Divider()
    }
}

struct POIDetailView_Previews: PreviewProvider {
    static var previews: some View {
        POIDetailView(store: POIDetailStore(presenter: POIDetailPresenter(interactor: POIDetailInteractor(), router: POIDetailRouter())), pointOfInterestId: 1)
    }
}
