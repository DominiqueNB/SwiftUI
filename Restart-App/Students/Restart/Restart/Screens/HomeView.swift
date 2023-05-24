import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var isAnimating: Bool = false
    
    private var homeText: Text = {
        return Text("The time that leads to mastery is dependent on the intensity of our focus.")
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.secondary)
    }()
    
    private var characterImage: some View = {
        return Image("character-2")
            .resizable()
            .scaledToFit()
            .padding()
    }()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - HEADER
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)

                characterImage
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
            }
            
            // MARK: - CENTER
            homeText
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - FOOTER
            
            Spacer()
            
            Button {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewActive.toggle()
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isAnimating.toggle()
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
