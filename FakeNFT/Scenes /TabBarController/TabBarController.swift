import UIKit

// MARK: - TabBarController

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    // MARK: - Private Properties

    private var catalogNavigationController: UINavigationController {
        let vc = CatalogViewController()
        let navVC = UINavigationController(rootViewController: vc)

        navVC.tabBarItem = UITabBarItem(
            title: L.Catalog.title,
            image: A.Icons.TabBar.catalog.image,
            selectedImage: nil
        )

        return navVC
    }

    private var cartNavigationController: UINavigationController {
        let vc = CartViewController()
        let navVC = UINavigationController(rootViewController: vc)

        navVC.tabBarItem = UITabBarItem(
            title: L.Cart.title,
            image: A.Icons.TabBar.cart.image,
            selectedImage: nil
        )

        return navVC
    }

    private var profileNavigationController: UINavigationController {
        let navigationController = ProfileNavigationController()
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]

        navigationController.tabBarItem = UITabBarItem(
            title: L.Profile.title,
            image: A.Icons.TabBar.profile.image,
            selectedImage: nil
        )
        return navigationController
    }

    private var statisticNavigationController: UINavigationController {
        let vc = StatisticViewController()
        let navVC = UINavigationController(rootViewController: vc)

        navVC.tabBarItem = UITabBarItem(
            title: L.Statistics.title,
            image: A.Icons.TabBar.statistic.image,
            selectedImage: nil
        )

        return navVC
    }

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        self.viewControllers = [
            profileNavigationController,
            catalogNavigationController,
            cartNavigationController,
            statisticNavigationController
        ]
    }

    // MARK: - Private Methods
    
    private func setupUI() {
        tabBar.backgroundColor = A.Colors.whiteDynamic.color
        tabBar.barTintColor = A.Colors.whiteDynamic.color
        tabBar.tintColor = A.Colors.blue.color
        tabBar.unselectedItemTintColor = A.Colors.blackDynamic.color
        tabBar.isTranslucent = false
        tabBar.barStyle = .default
    }

}
