import SwiftUI

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelVisible: Bool = false
    
    var circleIcon: some View = {
        return Image(systemName: "circle.circle")
            .symbolRenderingMode(.hierarchical)
            .resizable()
            .frame(width: 30, height: 30)
    }()
    
    var scaleIcon: some View = {
        return Image(systemName: "arrow.up.left.and.arrow.down.right")
    }()
    
    var widthIcon: some View = {
        return Image(systemName: "arrow.left.and.right")
    }()
    
    var heightIcon: some View = {
        return Image(systemName: "arrow.up.and.down")
    }()
    
    var body: some View {
        HStack {
            // MARK: - HOTSPOT
            circleIcon
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
            // MARK: - INFO PANEL
            HStack(spacing: 2) {
                scaleIcon
                Text("\(scale)")
                
                Spacer()
                
                widthIcon
                Text("\(offset.width)")
                
                Spacer()
                
                heightIcon
                Text("\(offset.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
