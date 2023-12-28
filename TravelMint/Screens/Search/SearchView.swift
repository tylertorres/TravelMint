//
//  SearchView.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var model: SearchViewModel = SearchViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchTextField(textInput: $model.locationTextInput, isFocused: _isTextFieldFocused)
                
                if !model.suggestedAddresses.isEmpty {
                    SearchResultListView(addresses: $model.suggestedAddresses) { address in
                        model.onAddressResultTapped(address)
                        isTextFieldFocused.toggle()
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
