//
//  DropDown.swift
//  Finding Falcone
//
//  Created by chinmay on 01/09/23.
//

import Foundation

import SwiftUI

struct CustomDropdown<T>: View where T: Hashable, T: CustomStringConvertible {
    let title: String
    let options: [T]
    @Binding var selectedOption: T?
    var onSelect: ((T) -> Void)?

    @State private var isExpanded = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                HStack {
                    Text(title)
                        .font(.system(size: 20, weight: .medium))
                        .fontDesign(.rounded)
                        .foregroundColor(.black)
                        .padding(.leading, 10)

                    Spacer()

                    Text(selectedOption?.description ?? "Select")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                        .fontDesign(.rounded)
                        .padding(.trailing, 10)

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Color.white)
                .cornerRadius(25)
                .border(Color.black, width: 1) // Black border around the rectangle
                .onTapGesture {
                    isExpanded.toggle()
                }
                .frame(maxWidth: .infinity)

                if isExpanded {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                                isExpanded = false
                                onSelect?(option)
                            }) {
                                Text(option.description)
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .medium))
                                    .fontDesign(.rounded)
                                    .padding(.leading, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(25)
                    .border(Color.black, width: 1) // Black border around the rectangle
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                    .frame(maxWidth: .infinity)
                    .offset(y: -10) // Adjust the vertical offset to overlap with the tab
                }
            }
        }
    }
}





struct CustomDropdown_Previews: PreviewProvider {
    @State static var selectedOption: String? = "Option 1"
    
    static var previews: some View {
        CustomDropdown(title: "Select an option", options: ["Option 1", "Option 2", "Option 3"], selectedOption: $selectedOption).padding(19)
    }
}
