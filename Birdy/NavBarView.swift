import SwiftUI

struct NavBarView: View {
    @State private var isExpanded: [String: Bool] = ["Rider": true, "Vehicle Owner": true, "Account": true]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Top Bar (simulating status bar and navigation)
                HStack {
                    Text("03:52 AM EDT")
                        .font(Font.custom("Nunito-Regular", size: 12) ?? .system(size: 12, weight: .medium))
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.8))
                    Spacer()
                    HStack(spacing: 8) {
                        Image(systemName: "wifi")
                            .foregroundColor(.black.opacity(0.8))
                        Image(systemName: "battery.75")
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
                .padding(.horizontal)
                .frame(height: 20)
                .background(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                // Navigation Bar with Search
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                    Text("Menu")
                        .font(Font.custom("Nunito-Bold", size: 20) ?? .system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    ZStack {
                        Image(systemName: "bubble.left.fill")
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                        Text("6")
                            .font(Font.custom("Nunito-Regular", size: 10) ?? .system(size: 10))
                            .foregroundColor(.white)
                            .frame(width: 14, height: 14)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 10, y: -10)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                // Menu Sections
                ScrollView {
                    VStack(spacing: 1) {
                        // Rider Section
                        
                        SectionView(title: "Rider", icon: "person.fill", isExpanded: Binding(
                            get: { isExpanded["Rider"] ?? true },
                            set: { isExpanded["Rider"] = $0 }
                        )) {
                            MenuItem(icon: "car.fill", title: "Get Ride")
                            
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(Color.gray.opacity(0.3))
                                .padding(.horizontal, 8)
                            
                            NavigationLink(destination: ProfileView()) {
                                MenuItem(icon: "pencil", title: "Edit Profile")
                            }
                        }
                        .padding(.vertical, 2)
                        
                      
                        // Vehicle Owner Section
                        SectionView(title: "Vehicle Owner", icon: "car", isExpanded: Binding(
                            get: { isExpanded["Vehicle Owner"] ?? true },
                            set: { isExpanded["Vehicle Owner"] = $0 }
                        )) {
                            NavigationLink(destination: GoogleMapView()) {
                                MenuItem(icon: "steeringwheel", title: "Go")
                            }

                            Rectangle()
                                .frame(height: 0.5) // thinner
                                .foregroundColor(Color.gray.opacity(0.3)) // lighter
                                .padding(.horizontal, 8)

                            MenuItem(icon: "dollarsign.circle", title: "Ratecard")
                        }
                        .padding(.vertical, 2)
                        
                        
                        // Account Section
                        SectionView(title: "Account", icon: "creditcard.fill", isExpanded: Binding(
                            get: { isExpanded["Account"] ?? true },
                            set: { isExpanded["Account"] = $0 }
                        )) {
                            MenuItem(icon: "person.3.fill", title: "Refer Points")
                            Rectangle()
                                .frame(height: 0.5) // thinner
                                .foregroundColor(Color.gray.opacity(0.3)) // lighter
                                .padding(.horizontal, 8)
                            MenuItem(icon: "gift.fill", title: "My Rewards")
                        }
                        .padding(.vertical, 2)
                        
                        // Help and Support
                        MenuItem(icon: "questionmark.circle.fill", title: "Help and Support")
                            .padding(.vertical, 2)
                    }
                    .background(Color.white)
                }
                .scrollContentBackground(.hidden)
            }
        }

        .task {
            // Ensure all sections are expanded on initial load
            isExpanded["Rider"] = true
            isExpanded["Vehicle Owner"] = true
            isExpanded["Account"] = true
            print("Initial isExpanded state: \(isExpanded)") // Debug print
            // Debug font availability
            for family in UIFont.familyNames {
                print("\(family): \(UIFont.fontNames(forFamilyName: family))")
            }
        }
    }
}

// Reusable Section View
struct SectionView<Content: View>: View {
    let title: String
    let icon: String
    @Binding var isExpanded: Bool
    let content: () -> Content
    
    init(title: String, icon: String, isExpanded: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.icon = icon
        self._isExpanded = isExpanded
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.black.opacity(0.7))
                        .frame(width: 24, height: 24)
                    Text(title)
                        .font(Font.custom("Nunito-SemiBold", size: 18) ?? .system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(8)
            }
            .background(Color.white)
            
            if isExpanded {
                content()
                    .transition(.opacity)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// Reusable Menu Item View
struct MenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.black.opacity(0.7))
                .frame(width: 24, height: 24)
            Text(title)
                .font(Font.custom("Nunito-Regular", size: 16) ?? .system(size: 16, weight: .regular))
                .foregroundColor(.black.opacity(0.8))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.5))
                .frame(width: 24, height: 24)
        }
        .padding(8)
        .background(Color.white)
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavBarView()
        }
    }
}
