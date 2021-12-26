//
//  InitialAnimationViewController.swift
//  Task
//
//  Created by Victor Mendes on 23/12/21.
//

import UIKit
import Lottie

class InitialAnimationViewController: UIViewController {
    @IBOutlet var logoView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoView.center = view.center
    }
    
    private func animation() {
        logoView = AnimationView(name: "checkMark_logo")
        logoView.contentMode = .scaleAspectFit
        view.addSubview(logoView)
        logoView.play(fromFrame: 58.0000023623884, toFrame: 1, loopMode: .autoReverse)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController: UINavigationController = storyboard.instantiateViewController(identifier: "NavigationMan")
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        })
    }
}
