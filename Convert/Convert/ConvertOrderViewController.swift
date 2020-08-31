import UIKit
import UIExtension

final class ConvertOrderViewController: UIViewController {

    var order = ""
    
    @IBOutlet weak var label: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = order
    }
}

extension ConvertOrderViewController: IBInstantiatable {}

import SwiftUI

extension ConvertOrderViewController: UIViewControllerRepresentable {}

struct ConvertOrderViewController_Previews: PreviewProvider {
    static var previews: some View {
        ConvertOrderViewController.instantiate()
    }
}
