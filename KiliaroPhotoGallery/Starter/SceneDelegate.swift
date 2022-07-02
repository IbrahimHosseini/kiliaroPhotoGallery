//
//  SceneDelegate.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let viewController = UIStoryboard.main.instantiate(viewController: ShareViewController.self)
        let network = NetworkController()
        let service = SharedMediaService(network: network)
        let viewModel = GalleryViewModel(service: service)
        viewController.initWith(viewModel)

        let navigationController = UINavigationController(rootViewController: viewController)

        // making root view controller to be the entry (UIViewController & AnyView) of
        // our first router
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

