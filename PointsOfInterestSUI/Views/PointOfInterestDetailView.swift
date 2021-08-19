//
//  PointOfInterestDetailView.swift
//  PointsOfInterestSUI
//
//  Created by elias on 13/8/21.
//

import SwiftUI

struct PointOfInterestDetailView: View {
    let pointOfInterest: PointOfInterest
    
    var body: some View {
        ScrollView {
            MapView(pointOfInterest: pointOfInterest)
                .frame(minWidth: 100, idealWidth: .infinity, maxWidth: .infinity, minHeight: 200, idealHeight: 250, maxHeight: 300, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(pointOfInterest.title)
                    .font(.title)
                Text(pointOfInterest.geocoordinates)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Divider()
                
                if let description = pointOfInterest.desc {
                    Text(description)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.top, .bottom])
                        .multilineTextAlignment(.leading)
                    Divider()
                }
                
                if let email = pointOfInterest.email {
                    RowView(iconName: "mail", info: email)
                }
                if let phone = pointOfInterest.phone {
                    RowView(iconName: "phone", info: phone)
                }
                if let transport = pointOfInterest.transport {
                    RowView(iconName: "car", info: transport)
                }
                if let address = pointOfInterest.address {
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

struct PointOfInterestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let description = "Casa Batlló is a key feature in the architecture of modernist Barcelona. It was built by Antoni Gaudí between 1904 and 1906 having been commissioned by the textile industrialist Josep Batlló. Nowadays, the spectacular facade is an iconic landmark in the city. The \"Manzana de la Discordia\", or Block of Discord, is a series of buildings in Passeig de Gràcia. It is home to a collection of works by the most renowned architects, amongst which is Casa Batlló. The house, now a museum, is open to the public, both for cultural visits and for celebrating events in its splendid modernist function rooms."
        let poi = PointOfInterest(id: 1,
                                  title: "Casa Batlló",
                                  geocoordinates: "41.391926,2.165208",
                                  desc: description,
                                  email: "info@casabatllo.cat",
                                  phone: "612345678",
                                  transport: "Underground:Passeig de Gràcia -L3",
                                  address: "Paseo de Gracia, 43, 08007 Barcelona")
        
        PointOfInterestDetailView(pointOfInterest: poi)
    }
}
