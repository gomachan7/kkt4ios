//
//  BaseViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/13.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import RxCocoa
import UIKit

extension UIViewController {

    func showLoadingView() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    func hideLoadingView() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }

    var loadingView: Binder<Bool> {
        return Binder(self) { (vc, value: Bool) in
            value ? vc.showLoadingView() : vc.hideLoadingView()
        }
    }
}
