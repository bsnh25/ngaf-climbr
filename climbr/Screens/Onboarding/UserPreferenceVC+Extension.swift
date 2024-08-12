//
//  UserPreferenceVC+Extension.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 11/08/24.
//

import Cocoa

extension UserPreferenceVC {
    
    class ButtonManager {
        private weak var viewController: UserPreferenceVC?
        private var buttons: [CLTextButtonV2: Selector] = [:]
        private weak var selectedButton: CLTextButtonV2?

        init(viewController: UserPreferenceVC) {
            self.viewController = viewController
        }

        func addButton(_ button: CLTextButtonV2, action: Selector) {
            buttons[button] = action
            button.target = self
            button.action = #selector(buttonTapped(_:))
        }

        @objc private func buttonTapped(_ sender: CLTextButtonV2) {
            guard sender != selectedButton else { return }
            
//            print("Button \(sender.title) tapped")
            
            // Unselect the previously selected button
            selectedButton?.isSelected = false

            // Select the new button
            sender.isSelected = true
            selectedButton = sender

            // Perform the associated action
            performButtonAction(for: sender)
        }

        private func performButtonAction(for button: CLTextButtonV2) {
            guard let viewController = viewController,
                  let action = buttons[button] else { return }
            
            viewController.perform(action)
        }
    }
}
