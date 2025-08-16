


import SwiftUI
import GoogleSignIn

struct GoogleSignInView: View {
    @State private var errorMessage: String? = nil
    @State private var isSignedIn = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Sign In to Birdy")
                    .font(.custom("Nunito-Bold", size: 28))
                    .foregroundColor(Color.blue)
                
                Button(action: handleGoogleSignIn) {
                    Text("Sign in with Google")
                        .font(.custom("Nunito-Bold", size: 16))
                        .foregroundColor(Color(red: 30/255, green: 64/255, blue: 175/255))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(red: 30/255, green: 64/255, blue: 175/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 30/255, green: 64/255, blue: 175/255), lineWidth: 1)                        )
                }
                .padding(.horizontal)
                
                if let error = errorMessage {
                    Text(error)
                        .font(.custom("Nunito-Regular", size: 14))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                NavigationLink(destination: HomeView(), isActive: $isSignedIn) {
                    EmptyView()
                }
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 230/255, green: 240/255, blue: 250/255),
                        Color(red: 179/255, green: 205/255, blue: 224/255)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
    }
    
    private func handleGoogleSignIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            errorMessage = "Failed to sign in with Google. Please try again."
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                errorMessage = "Failed to sign in with Google. Please try again."
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                errorMessage = "Failed to sign in with Google. Please try again."
                return
            }
            
            // Successfully signed in; use idToken to authenticate with your backend
            print("Google Sign-In successful: \(user.profile?.email ?? "No email")")
            errorMessage = nil
            isSignedIn = true
        }
    }
}



// Placeholder for the next view after successful sign-in
struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Birdy!")
                .font(.custom("Nunito-Bold", size: 28))
                .foregroundColor(Color.blue)
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 230/255, green: 240/255, blue: 250/255),
                    Color(red: 179/255, green: 205/255, blue: 224/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInView()
    }
}

// UIColor extension for hex colors, adapted for SwiftUI
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 3: // RGB (12-bit)
            r = Double((int >> 8) * 17) / 255
            g = Double((int >> 4 & 0xF) * 17) / 255
            b = Double((int & 0xF) * 17) / 255
        case 6: // RGB (24-bit)
            r = Double(int >> 16) / 255
            g = Double(int >> 8 & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0
        }
        self.init(red: r, green: g, blue: b)
    }
}
