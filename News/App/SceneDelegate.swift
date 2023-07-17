//
//  SceneDelegate.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow()
        window?.windowScene = scene as? UIWindowScene
        let newsViewModel = NewsListViewModel(dependencies: .init(apiService: NewsAPIClient()))
        let newsListView = NewsListViewController(newsViewModel: newsViewModel)
        let navController = UINavigationController(rootViewController: newsListView)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
