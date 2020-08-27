import UIKit
import UIExtension

public protocol ConvertPresenterCoordinator: AnyObject {

    func presenterGoToBuyCrypto(_ presenter: ConvertPresenter)
}

public class ConvertPresenter: Presenter {

    public weak var coordinator: ConvertPresenterCoordinator?

    let root: ConvertViewController

    let order: ConvertOrderPresenter

    public init() {
        root = .instantiate()
        order = ConvertOrderPresenter()
        super.init(nibName: nil, bundle: nil)
        root.coordinator = self
        root.embed(in: self)
        navigationItem.title = "Convert"
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    deinit {
        root.unembed()
    }
}

extension ConvertPresenter: ConvertViewControllerCoordinator {

    func viewControllerGoToHistory(_ viewController: ConvertViewController) {
        navigationController?.pushViewController(order, animated: true)
    }

    func viewControllerGoToBuyCrypto(_ viewController: ConvertViewController) {
        coordinator?.presenterGoToBuyCrypto(self)
    }
}
