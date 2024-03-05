//
//  SceneDelegate.swift
//  Tasks
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        
        let tasksViewController = TasksViewController()
        let navigationController = UINavigationController(rootViewController: tasksViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }

}

