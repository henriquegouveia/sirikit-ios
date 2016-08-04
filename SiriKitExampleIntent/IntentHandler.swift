//
//  IntentHandler.swift
//  SiriKitExampleIntent
//
//  Created by Henrique Gouveia on 8/3/16.
//  Copyright © 2016 CI&T. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, INSendMessageIntentHandling {
    
    override func handler(for intent: INIntent) -> AnyObject {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    // MARK: - INSendMessageIntentHandling
    
    // Implement resolution methods to provide additional information about your intent (optional).
    func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: ([INPersonResolutionResult]) -> Void) {
        if let recipients = intent.recipients {

            // If no recipients were provided we'll need to prompt for a value.
            if recipients.count == 0 {
                completion([INPersonResolutionResult.needsValue()])
                return
            }

            var resolutionResults = [INPersonResolutionResult]()
            for recipient in recipients {
                let matchingContacts = [recipient] // Implement your contact matching logic here to create an array of matching contacts
                switch matchingContacts.count {
                case 2  ... Int.max:
                    // We need Siri's help to ask user to pick one from the matches.
                    resolutionResults += [INPersonResolutionResult.disambiguation(with: matchingContacts)]

                case 1:
                    // We have exactly one matching contact
                    resolutionResults += [INPersonResolutionResult.success(with: recipient)]

                case 0:
                    // We have no contacts matching the description provided
                    resolutionResults += [INPersonResolutionResult.unsupported()]

                default:
                    break

                }
            }
            completion(resolutionResults)
            
        }
    }

    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: (INStringResolutionResult) -> Void) {
        if let text = intent.content, !text.isEmpty {
            let contents = DataProvider.filterItem(itemDescription: text)
            switch contents.count {
            case 0:
                completion(INStringResolutionResult.needsValue())
                break
            case 1:
                completion(INStringResolutionResult.success(with: text))
                break
            default:
                completion(INStringResolutionResult.disambiguation(with: contents.map { "\($0.category) \($0.model) \($0.color)" }))
            }
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    // Once resolution is completed, perform validation on the intent and provide confirmation (optional).
    
    func confirm(sendMessage intent: INSendMessageIntent, completion: (INSendMessageIntentResponse) -> Void) {
        // Verify user is authenticated and your app is ready to send a message.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }
    
    // Handle the completed intent (required).
    
    func handle(sendMessage intent: INSendMessageIntent, completion: (INSendMessageIntentResponse) -> Void) {
        // Implement your application logic to send a message here.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
    

    // MARK: - INSetMessageAttributeIntentHandling
    
    func handle(setMessageAttribute intent: INSetMessageAttributeIntent, completion: (INSetMessageAttributeIntentResponse) -> Void) {
        // Implement your application logic to set the message attribute here.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSetMessageAttributeIntent.self))
        let response = INSetMessageAttributeIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
}

