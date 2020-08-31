import UIKit
import UIExtension

protocol ConvertViewControllerCoordinator: AnyObject {

    func viewControllerGoToHistory(_ viewController: ConvertViewController)

    func viewControllerGoToBuyCrypto(_ viewController: ConvertViewController)
}

class ConvertViewController: UIViewController {

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
