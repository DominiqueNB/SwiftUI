//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI

struct LinkBasicView: View {
  var body: some View {
    Link("Go to Apple", destination: URL(string: "https://apple.com")!)
      .font(.largeTitle)
  }
}

struct LinkBasicView_Previews: PreviewProvider {
  static var previews: some View {
    LinkBasicView()
  }
}
