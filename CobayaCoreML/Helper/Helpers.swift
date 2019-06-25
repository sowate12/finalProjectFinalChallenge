//
//  Helpers.swift
//  CobayaCoreML
//
//  Created by keenan warouw on 24/06/19.
//  Copyright © 2019 Keenan Warouw. All rights reserved.
//

import Foundation
import UIKit

class alertController {
    
    class func showSimpleAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, inViewController vc: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(viewController: alertController, inViewController: vc)
    }
    
    class func showAlertWithActions(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction], inViewController vc: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alertController.addAction(action)
        }
        present(viewController: alertController, inViewController: vc)
    }
    
    class func present(viewController vcToPresent: UIViewController, inViewController inVC: UIViewController?) {
        if let vc = inVC {
            vc.present(vcToPresent, animated: true, completion: nil)
        }else if let delegate = UIApplication.shared.delegate, let window = delegate.window, let rootVC = window?.rootViewController {
            rootVC.present(vcToPresent, animated: true, completion: nil)
        }
    }
}
