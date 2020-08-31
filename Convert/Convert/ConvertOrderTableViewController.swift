import UIKit
import UIExtension

protocol ConvertOrderTableViewControllerCoordinator: AnyObject {

    func viewController(_ viewController: ConvertOrderTableViewController, didSelect order: String)
}

final class ConvertOrderTableViewController: UITableViewController {

    weak var coordinator: ConvertOrderTableViewControllerCoordinator?
}

extension ConvertOrderTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.viewController(self, didSelect: "\(indexPath.row)")
    }
}

extension ConvertOrderTableViewController: IBInstantiatable {}

import SwiftUI

extension ConvertOrderTableViewController: UIViewControllerRepresentable {}

struct ConvertOrderTableViewController_Previews: PreviewProvider {
    static var previews: some View {
        ConvertOrderTableViewController.instantiate()
    }
}
