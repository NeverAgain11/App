import UIKit

extension UIViewController {

    @inlinable
    public func embed(in parent: UIViewController) {
        parent.addChild(self)
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }

    @inlinable
    public func unembed() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
