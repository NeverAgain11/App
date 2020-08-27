import UIExtension

public protocol HomePresenterCoordinator: AnyObject {

    func presenterGoToConvert(_ presenter: HomePresenter)
}

public class HomePresenter: Presenter, SBIdentifiedUnarchivable {

    public weak var coordinator: HomePresenterCoordinator?

    @inlinable
    public static var sbName: String {
        return "Main"
    }

    @IBAction
    func goToConvert() {
        coordinator?.presenterGoToConvert(self)
    }
}
