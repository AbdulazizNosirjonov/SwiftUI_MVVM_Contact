//
//  ContactCell.swift
//  SwiftUI_MVVM_Contact
//
//  Created by Abdulaziz Nosirjonov on 04/12/22.
//

import SwiftUI

struct ContactCell: View {
    var contact: Contact
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Text(contact.name!.uppercased()).fontWeight(.bold)
                Spacer()
            }
            Text(contact.number!)
                .frame(maxWidth: self.width - 40)
                .padding(.top, 5)
        }
        .padding()
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact())
    }
}
