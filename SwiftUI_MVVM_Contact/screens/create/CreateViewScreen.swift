//
//  CreateViewScreen.swift
//  SwiftUI_MVVM_Contact
//
//  Created by Abdulaziz Nosirjonov on 04/12/22.
//

import SwiftUI

struct CreateViewScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State var textFieldName = ""
    @State var textFieldNumber = ""
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var viewModel = CreateViewModel()
    @State var contact: Contact = Contact(name: "", number: "")
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
            Button{
                if textFieldName.isEmpty || textFieldNumber.isEmpty {
                    print("bosh qiymat")
                }else{
                    contact.name = textFieldName
                    contact.number = textFieldNumber
                    viewModel.apiContactCreate(contact: contact, handler: { isCreated in
                        if isCreated {
                            print("Created")
                        }
                    })
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Add Contact")
                    .padding(20)
                    .frame(width: self.width - 40)
                    .foregroundColor(.white)
                    .background(Color.blue)
            }
            .padding(.bottom, 20)
        }.padding(.top, 50)
    }
}
struct CreateViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateViewScreen()
    }
}
