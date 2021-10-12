import SwiftUI

struct LoadableView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
            ProgressView()
        }
    }
}

struct LoadableView_Previews: PreviewProvider {
    static var previews: some View {
        LoadableView()
    }
}
