import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        if let window {
            /// The following should be handled by some navigation layer (for instance coordinators but let keep it simple for this exercise) along with factories. For simplicity sake I'll just implement it as is.
            let navigationController = UINavigationController()

            let itemsListViewController = ItemsListViewController()
            itemsListViewController.didTapItem = { [weak navigationController] item in
                /// Since no large image were returned by the API, I work with small ones. I took the side of not showing details whenever the image Url is empty or nil.
                if let imageUrlString = item.imageUrls?.small, !imageUrlString.isEmpty {
                    let itemDetailsViewController = ItemDetailsViewController(imageUrlString: imageUrlString)
                    navigationController?.pushViewController(itemDetailsViewController, animated: true)
                }
            }

            let itemsListInteractor = ItemsListInteractor(service: GetItemsServiceImpl())
            let itemsListPresenter = ItemsListPresenter()

            ItemsListAssembler.assemble(itemsListViewController, itemsListInteractor, itemsListPresenter)

            navigationController.viewControllers = [itemsListViewController]

            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
