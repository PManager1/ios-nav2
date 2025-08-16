//
//  ContentView.swift
//  Birdy
//
//  Created by jay P on 8/16/25.


import SwiftUI

// Navigation Controller View
struct NavigationControllerView: View {
//    @StateObject private var authManager = AuthManager()
    @State private var showSplash = true
    
    var body: some View {
        NavigationStack {
//            Group {
//                if showSplash {
//                    SplashScreenView()
//                } else {
//                    if authManager.isLoggedIn {
//                        HomeView()
//                    } else {
//                        SignInView()
//                    }
//                }
//            }
            Group {
                           if showSplash {
                               SplashScreenView()
                           } else {
                               // Directly show the HomeView
                               HomeView()
                           }
                       }
                   }
        .onAppear {
            // Display splash screen for 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}



// Splash Screen View
struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.purple // Custom non-white background
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "bird.fill") // Changed to bird icon for Birdy2 app
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
                
                Text("Birdy2")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
        }
    }
}

// Auth Manager to handle login state
class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        // Check for existing token (e.g., from UserDefaults)
        if let _ = UserDefaults.standard.string(forKey: "loginToken") {
            isLoggedIn = true
        }
    }
    
    func signIn(token: String) {
        UserDefaults.standard.set(token, forKey: "loginToken")
        isLoggedIn = true
    }
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: "loginToken")
        isLoggedIn = false
    }
}


// Sign In View


// struct SignInView: View {
//     @EnvironmentObject var authManager: AuthManager
//     @State private var username: String = ""
//     @State private var password: String = ""
    
//     var body: some View {
//         VStack(spacing: 20) {
//             Text("Sign In")
//                 .font(.largeTitle)
//                 .fontWeight(.bold)
            
//             TextField("Username", text: $username)
//                 .textFieldStyle(.roundedBorder)
//                 .padding(.horizontal)
            
//             SecureField("Password", text: $password)
//                 .textFieldStyle(.roundedBorder)
//                 .padding(.horizontal)
            
//             // Button(action: {
//             //     // Simulate login (replace with actual auth logic)
//             //     authManager.signIn(token: "sampleToken")
//             // }) 
//             Button(action: {
//     if username == "a" && password == "a" {
//         authManager.signIn(token: "validToken")
//     } else {
//         // Optionally, show an alert or message for invalid credentials
//         print("Invalid username or password")
//     }
// })
            
//             {
//                 Text("Sign In")
//                     .font(.headline)
//                     .padding()
//                     .frame(maxWidth: .infinity)
//                     .background(Color.blue)
//                     .foregroundStyle(.white)
//                     .clipShape(RoundedRectangle(cornerRadius: 10))
//             }
//             .padding(.horizontal)
//         }
//         .padding()
//         .background(Color.gray.opacity(0.1).ignoresSafeArea())
//         .navigationTitle("Sign In")
//         .navigationBarTitleDisplayMode(.inline)
//     }
// }

// Preview
struct NavigationControllerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationControllerView()
            .environmentObject(AuthManager())
    }
}
