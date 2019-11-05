import SwiftUI

struct LoginView: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                Text("Feed")
            }
            ProfileView().tabItem {
                Text("Profile")
            }
        }    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
       
