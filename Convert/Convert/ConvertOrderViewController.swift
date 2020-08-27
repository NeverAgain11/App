import UIKit
import UIExtension

class ConvertOrderViewController: UIViewController {

    var order = ""
    
    @IBOutlet weak var label: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = order
    }
}

extension ConvertOrderViewController: SBUnarchivable {}
