import UIKit
import UIExtension
import Convert
import OtherPages

protocol TradePagePresenterCoordinator: AnyObject {

    func presenterGoToBuyCrypto(_ presenter: TradePagePresenter)
}

class TradePagePresenter: PagePresenter {

    weak var coordinator: TradePagePresenterCoordinator?

    let page1: ConvertPresenter

    let page2: SpotPresenter

    let page3: MarginPresenter

    init() {
        page1 = ConvertPresenter()
        page2 = .instantiate()
        page3 = .instantiate()
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        page1.coordinator = self
        setViewControllers([page2], direction: .forward, animated: false)
        navigationItem.title = page2.navigationItem.title
        dataSource = self
        delegate = self
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension TradePagePresenter: ConvertPresenterCoordinator {

    func presenterGoToBuyCrypto(_ presenter: ConvertPresenter) {
        coordinator?.presenterGoToBuyCrypto(self)
    }
}

extension TradePagePresenter: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case is SpotPresenter:
            return page1
        case is MarginPresenter:
            return page2
        default:
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case is ConvertPresenter:
            return page2
        case is SpotPresenter:
            return page3
        default:
            return nil
        }
    }
}

extension TradePagePresenter: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        navigationItem.title = pageViewController.viewControllers?.first?.navigationItem.title
    }
}
