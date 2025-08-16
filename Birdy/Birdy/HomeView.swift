
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            Text("Home Screen")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .navigationTitle("Home Screen")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
