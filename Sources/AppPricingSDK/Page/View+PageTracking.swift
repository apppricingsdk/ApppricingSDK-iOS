import SwiftUI

public extension View {
    func track(pageName: String) -> some View {
        self.onAppear {
            AppPricingInstance.postPageRequest(pageName: pageName)
        }
    }
}
