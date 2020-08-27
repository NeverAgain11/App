import UIKit
import UIExtension
import Fiat
import OtherPages

public class TradeNavigationPresener: NavigationPresener {

    let root: TradePagePresenter

    let fiat: FiatPresenter

    public init() {
        root = TradePagePresenter()
        fiat = FiatPresenter()
        super.init(rootViewController: root)
        root.coordinator = self
        tabBarItem = UITabBarItem(
            title: "Trade",
            image: UIImage(systemName: "3.square"),
            selectedImage: UIImage(systemName: "3.square.fill"))
    }

    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension TradeNavigationPresener {

    public func showConvert() {
        let convert = root.page1
        root.setViewControllers([convert], direction: .reverse, animated: true)
        root.navigationItem.title = convert.navigationItem.title
    }
}

extension TradeNavigationPresener: TradePagePresenterCoordinator {

    func presenterGoToBuyCrypto(_ presenter: TradePagePresenter) {
        present(fiat, animated: true)
    }
}
