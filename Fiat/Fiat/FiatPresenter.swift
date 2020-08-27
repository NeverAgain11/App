import SwiftUI
import UIExtension

public class FiatPresenter: HostingPresenter<FiatView> {

    public init() {
        super.init(rootView: FiatView())
    }

    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
