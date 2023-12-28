//
//  LocationSearchTextField.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import SwiftUI

enum SearchFocusable: Hashable {
    case isFocused
}

struct SearchTextField: View {
    
    @ObservedObject var model: SearchViewModel
    @Binding var textInput: String
    @FocusState private var isFocused: SearchFocusable?
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
            
            TextField("Enter address...", text: $textInput)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
                .focused($isFocused, equals: .isFocused)
        }
        .padding()
        .background(.gray, in: RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
        .onChange(of: isFocused) { model.isTextFieldFocused = $0 }
        .onChange(of: model.isTextFieldFocused) { isFocused = $0 }
    }
}

struct LocationSearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(model: SearchViewModel(), textInput: .constant("Test"))
    }
}
