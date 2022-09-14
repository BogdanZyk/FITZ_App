//
//  DropdownView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

struct DropdownView<T: DropdownItemProtocol>: View {
    @Binding var dropdown: T
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(dropdown.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }
            Button {
                dropdown.isSelected = true
            } label: {
                HStack{
                    Text(dropdown.dropdownTitle)
                        .font(.system(size: 25, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 22, weight: .medium))
                }
            }
            .buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
            
        }
        .padding()
        .confirmationDialog("Select", isPresented: $dropdown.isSelected) {
            confirmButtons
        }
    }
}

extension DropdownView{
    private var confirmButtons: some View{
        Group {
            

            
            ForEach(dropdown.options.indices, id: \.self){ index in
                Button(dropdown.options[index].formatted, action: {
                    dropdown.selectedOption = dropdown.options[index]
                })
            }
           // Button("Cancel", role: .cancel, action: dropdown.clearIsSelectedAllDropdowns)
        }
    }
}


