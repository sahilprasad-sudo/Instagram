import SwiftUI
import Playgrounds

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    var body: some View {
        Group{
            if(viewModel.userSession == nil){
                LoginView()
                    .environmentObject(registrationViewModel)
            }
            else{
                MainTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
