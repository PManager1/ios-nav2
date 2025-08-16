import SwiftUI
import GoogleMaps

struct GoogleMapView: View {
    @State private var isButtonPressed = false
    
    var body: some View {
        VStack {
            MapViewRepresentable()
                .frame(maxHeight: UIScreen.main.bounds.height * 0.8) // Limit map height to 80% of screen
                .edgesIgnoringSafeArea(.top)
            
            Spacer() // Pushes button to bottom
            
            Button(action: {
                isButtonPressed.toggle()
            }) {
                Text("Start Driving")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isButtonPressed ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationTitle("Go Screen")
    }
}

// Separate struct for the UIKit map representation
struct MapViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "DC"
        marker.snippet = "US"
        marker.map = mapView

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView()
    }
}
 
