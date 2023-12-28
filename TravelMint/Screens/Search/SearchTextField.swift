//
//  LocationSearchTextField.swift
//  TravelMint
//
//  Created by Tyler Torres on 12/27/23.
//

import SwiftUI

struct SearchTextField: View {
    
    @Binding var textInput: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
            
            TextField("Enter address...", text: $textInput)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
                .focused($isFocused)
        }
        .padding()
        .background(.gray, in: RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
    }
}

struct LocationSearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(textInput: .constant("Test"))
    }
}
