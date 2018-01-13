//
//  ViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/02.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxCocoa
import RxSwift
import KYDrawerController

class HomeViewController: BarPagerTabStripViewController {
    
    @IBOutlet weak var headerMenu: HeaderMenu!

    private let disposeBag = DisposeBag()
    private let myTlVC = MyTimeLineViewController()
    private let localTlVC = LocalTimelineViewController()
    private let notiVC = NotificationViewController()
    private let favVC = FavoriteViewController()
    private let searchVC = SearchViewController()
    
    // MARK: - Static

    static func withDrawer() -> UIViewController {
        let withDraerVC = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        let mainViewController = HomeViewController()
        let drawerViewController = DrawerViewController()

        withDraerVC.mainViewController = mainViewController
        withDraerVC.drawerViewController = drawerViewController
        
        return withDraerVC
    }

    override func viewDidLoad() {
        self.configureButtonBarStyle()
        self.setupView()
        self.registerHeaderMenuHandling()

        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [self.myTlVC, self.localTlVC, self.notiVC, self.favVC, self.searchVC]
    }

    // MARK: - private
    
    private func onTapKatsu() {
        let katsuFormVC: UIViewController = KatsuFormViewController()

        self.present(katsuFormVC, animated: true, completion: nil)
    }
    
    private func setupView() {
        if let image = UIImage(named: "bg_main.png") {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    private func configureButtonBarStyle() {
        settings.style.barBackgroundColor = UIColor.yellow
        settings.style.selectedBarBackgroundColor = UIColor.blue
        settings.style.barHeight = 4
    }
    
    private func registerHeaderMenuHandling() {
        self.headerMenu.myTlButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.myTlVC, animated: true)
            }).disposed(by: self.disposeBag)

        self.headerMenu.localTlButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.localTlVC, animated: true)
            }).disposed(by: self.disposeBag)

        self.headerMenu.notiButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.notiVC, animated: true)
            }).disposed(by: self.disposeBag)

        self.headerMenu.favButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.favVC, animated: true)
            }).disposed(by: self.disposeBag)

        self.headerMenu.searchButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.searchVC, animated: true)
            }).disposed(by: self.disposeBag)

        self.headerMenu.katsuButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onTapKatsu()
            }).disposed(by: self.disposeBag)
    }
}