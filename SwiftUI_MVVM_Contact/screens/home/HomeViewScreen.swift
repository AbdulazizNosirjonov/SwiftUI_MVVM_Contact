import SwiftUI
struct HomeViewScreen: View {
    @State private var showingEdit = false
    @ObservedObject var viewModel = HomeViewModel()
    func delete(indexSet: IndexSet){
        let contact = viewModel.contacts[indexSet.first!]
        viewModel.apiContactDelete(contact: contact, handler: { value in
            if value { viewModel.apiContactList() }
        })
    }
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.contacts, id: \.self){ contact in
                        ContactCell(contact: contact)
                            .onLongPressGesture {
                                showingEdit.toggle()
                                UserDefaults.standard.set("\(contact.name ?? "")" , forKey: "ContactName")
                                UserDefaults.standard.set("\(contact.number ?? "")", forKey: "ContactNumber")
                                UserDefaults.standard.set("\(contact.id ?? "")", forKey: "ContactId")
                            }.sheet(isPresented: $showingEdit) { EditViewScreen() }
                    }.onDelete(perform: delete)
                }.listStyle(PlainListStyle())
                if viewModel.isLoading { ProgressView() }
            }
            .navigationBarTitle("SwiftUI MVVM Contacts", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                viewModel.apiContactList()
            }, label: {
                Image("ic_refresh")
            }), trailing: NavigationLink(destination: {
                CreateViewScreen()
            }, label: {
                Image("ic_add")
            }))
        }.onAppear{
            viewModel.apiContactList()
            setNavigationBar()
        }
    }
}

struct HomeViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewScreen()
    }
}


func setNavigationBar () {
    UINavigationBar.appearance().barTintColor = UIColor.gray
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
}
