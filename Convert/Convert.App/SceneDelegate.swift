import UIKit
import Convert

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let root = ConvertPresenter()
            root.coordinator = self
            window.rootViewController = root
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

extension SceneDelegate: ConvertPresenterCoordinator {

    func presenterGoToBuyCrypto(_ presenter: ConvertPresenter) {
        print("ConvertPresenterGoToBuyCrypto")
    }
}
