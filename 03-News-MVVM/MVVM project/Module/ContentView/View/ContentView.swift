import SwiftUI

struct ContentView: View {
    @State var vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(vm.news, id: \.self) { item in
                    VStack{
                        Text(item.autor ?? "")
                        Text(item.title ?? "")
                    }
                }
            }
            .navigationTitle("Поиск")
            .searchable(
                text: $vm.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Введите название новости"
            )
            .onSubmit(of: .search){
                vm.sendRequest()
            }
        }
    }
}
#Preview {
    ContentView()
}
