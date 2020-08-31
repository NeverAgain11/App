import UIKit
import UIExtension

protocol ConvertViewControllerCoordinator: AnyObject {

    func viewControllerGoToHistory(_ viewController: ConvertViewController)

    func viewControllerGoToBuyCrypto(_ viewController: ConvertViewController)
}

final class ConvertViewController: UIViewController {

    weak var coordinator: ConvertViewControllerCoordinator?
}

extension ConvertViewController {

    @IBAction
    func goToHistory() {
        coordinator?.viewControllerGoToHistory(self)
    }

    @IBAction
    func goToBuyCrypto() {
        coordinator?.viewControllerGoToBuyCrypto(self)
    }
}

extension ConvertViewController: IBInstantiatable {}

import SwiftUI

extension ConvertViewController: UIViewControllerRepresentable {}

struct ConvertViewController_Previews: PreviewProvider {
    static var previews: some View {
        ConvertViewController.instantiate()
    }
}
