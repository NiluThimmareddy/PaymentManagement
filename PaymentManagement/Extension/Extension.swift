//
//  Extension.swift
//  PaymentManagement
//
//  Created by ToqSoft on 28/04/25.
//

import Foundation

import UIKit

extension UIViewController {
    func showAlert(
        title: String = "Alert",
        message: String,
        actions: [(title: String, style: UIAlertAction.Style, handler: (() -> Void)?)] = [("OK", .default, nil)],
        autoDismissAfter delay: TimeInterval? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for actionInfo in actions {
            let action = UIAlertAction(title: actionInfo.title, style: actionInfo.style) { _ in
                actionInfo.handler?()
            }
            alertController.addAction(action)
        }

        self.present(alertController, animated: true)

        if let delay = delay {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                alertController.dismiss(animated: true)
            }
        }
    }
}
