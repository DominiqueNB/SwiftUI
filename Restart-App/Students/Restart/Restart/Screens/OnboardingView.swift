import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    
    private var titleText: Text = {
        return Text("Share.")
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
    }()
    
    private var subtitleText: Text = {
        return Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
        .font(.title3)
        .fontWeight(.light)
        .foregroundColor(.white)
    }()
    
    private var characterImage: some View = {
        return Image("character-1")
            .resizable()
            .scaledToFit()
    }()
    
    private var iconImage: some View = {
        return Image(systemName: "chevron.right.2")
            .font(.system(size: 24, weight: .bold))
    }()
    
    private var buttonText: Text = {
        return Text("Get Started")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
    }()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // MARK: - HEADER
                Spacer()
                
                VStack(spacing: 0) {
                    titleText
                    subtitleText
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    
                    characterImage
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                }
                
                Spacer()
                // MARK: - FOOTER
                
                ZStack {
                    
                    // 1. BACKGROUND (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    buttonText
                        .offset(x: 20)
                    
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            iconImage
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            slideGesture()
                        )
                        
                        Spacer()
                    } //: HSTACK
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating.toggle()
        })
    }
    
    private func slideGesture() -> some Gesture
    {
        DragGesture()
            .onChanged({ gesture in
                if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                }
            })
            .onEnded({ _ in
                    withAnimation(Animation.easeOut(duration: 0.8)) {
                        if buttonOffset > buttonWidth / 2 {
                            buttonOffset = buttonWidth - 80
                            isOnboardingViewActive.toggle()
                        } else {
                            buttonOffset = 0
                        }
                    }
            })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
