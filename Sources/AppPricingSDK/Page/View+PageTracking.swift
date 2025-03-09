import SwiftUI

public extension View {
    func track(pageName: String) -> some View {
        self.onAppear {
            Task.detached {
                try await AppPricingInstance.postPageRequest(pageName: pageName)
            }
        }
    }
}
