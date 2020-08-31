import UIKit

public extension UIViewController {

    @inlinable
    func embed(in parent: UIViewController) {
        parent.addChild(self)
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }

    @inlinable
    func unembed() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
