//
//  ViewController.swift
//  SiriKitExample
//
//  Created by Henrique Gouveia on 8/3/16.
//  Copyright © 2016 CI&T. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestAuthorizationForSiriAccessTheApp()
        self.addVocabularyToSiri()
    }

    // MARK: Private Methods

    private func requestAuthorizationForSiriAccessTheApp() {
        if INPreferences.siriAuthorizationStatus() != .authorized{
            INPreferences.requestSiriAuthorization { (INSiriAuthorizationStatus) in
                if INSiriAuthorizationStatus == .authorized{
                    print("Application Authorized")
                }
            }
        } else {
            print("We're already good")
        }
    }

    private func addVocabularyToSiri() {
        DispatchQueue(label: "SiriVocabulary").async {
            let contacts = NSOrderedSet(array: ["Atacadão"])

            let vocabulary = INVocabulary.shared()
            vocabulary.setVocabularyStrings(contacts, of: .contactName)
        }
    }
}

