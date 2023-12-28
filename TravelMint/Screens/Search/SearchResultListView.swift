//
//  SearchResultListView.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import SwiftUI

struct SearchResultListView: View {
    
    @Binding var addresses: [AddressResult]
    
    var onAddressResultTapped: (AddressResult) -> Void
    
    var body: some View {
        List {
            ForEach(addresses, id: \.id) { address in
                Button(action: {
                    onAddressResultTapped(address)
                }) {
                    VStack(alignment: .leading) {
                        Text(address.title)
                            .font(.headline)
                        Text(address.subtitle)
                            .font(.subheadline)
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}

struct SearchResultListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultListView(addresses: .constant([AddressResult(title: "19236 Briarbrook Dr", subtitle: "Tampa, FL, United States")]), onAddressResultTapped: {_ in })
    }
}
