//
//  SearchView.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var model: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchTextField(model: model, textInput: $model.locationTextInput)
                
                if !model.suggestedAddresses.isEmpty {
                    SearchResultListView(addresses: $model.suggestedAddresses) { address in
                        model.onAddressResultTapped(address)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
