import UIKit
import UIExtension
import Trade
import OtherTabs

class RootPresenter: TabPresenter {

    let tab1: HomePresenter

    let tab2: MarketsPresenter

    let tab3: TradeNavigationPresener

    let tab4: FuturesPresenter

    let tab5: WalletsPresenter

    init() {
        tab1 = .instantiate()
        tab2 = .instantiate()
        tab3 = TradeNavigationPresener()
        tab4 = .instantiate()
        tab5 = .instantiate()
        super.init(nibName: nil, bundle: nil)
        tab1.coordinator = self
        viewControllers = [tab1, tab2, tab3, tab4, tab5]
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension RootPresenter: HomePresenterCoordinator {

    func presenterGoToConvert(_ presenter: HomePresenter) {
        selectedViewController = tab3
        tab3.showConvert()
    }
}
