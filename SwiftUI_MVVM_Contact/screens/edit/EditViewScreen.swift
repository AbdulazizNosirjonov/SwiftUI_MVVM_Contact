//
//  EditViewScreen.swift
//  SwiftUI_MVVM_Contact
//
//  Created by Abdulaziz Nosirjonov on 04/12/22.
//

import SwiftUI

struct EditViewScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State var textFieldName = ""
    @State var textFieldNumber = ""
    var width = UIScreen.main.bounds.width
    @State var contact: Contact = Contact(name: "", number: "")
    var viewModel = EditViewModel()
    var body: some View {
        VStack{
            TextField("title", text: $textFieldName)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                .padding(10)
            
            TextField("body", text: $textFieldNumber)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                .padding(10)
            Spacer()
            Button {
                if textFieldName.isEmpty || textFieldNumber.isEmpty {
                    print("bosh qiymat")
                }else{
                    contact.name = textFieldName
                    contact.number = textFieldNumber
                    viewModel.apiContactEdit(contact: contact, handler: { isEdited in
                        if isEdited { print("Edited") }
                    })
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Edit Contact")
                    .padding(20)
                    .frame(width: self.width - 40)
                    .foregroundColor(.white)
                    .background(Color.blue)
            }.padding(.bottom, 20)
        }
        .padding(.top, 50)
        .onAppear{
            contact.name = UserDefaults.standard.string(forKey: "ContactName")?.uppercased()
            contact.number = UserDefaults.standard.string(forKey: "ContactNumber")
            contact.id = UserDefaults.standard.string(forKey: "ContactId")
            textFieldName = contact.name ?? ""
            textFieldNumber = contact.number ?? ""
        }
    }
}

struct EditViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditViewScreen()
    }
}
