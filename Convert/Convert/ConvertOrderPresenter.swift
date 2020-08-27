import UIKit
import UIExtension

class ConvertOrderPresenter: Presenter {

    let master: ConvertOrderTableViewController

    let detail: ConvertOrderViewController

    init() {
        master = .instantiate()
        detail = .instantiate()
        super.init(nibName: nil, bundle: nil)
        master.coordinator = self
        master.embed(in: self)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    deinit {
        master.unembed()
    }
}

extension ConvertOrderPresenter: ConvertOrderTableViewControllerCoordinator {

    func viewController(_ viewController: ConvertOrderTableViewController, didSelect order: String) {
        detail.order = order
        navigationController?.pushViewController(detail, animated: true)
    }
}
