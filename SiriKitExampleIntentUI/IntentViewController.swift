//
//  IntentViewController.swift
//  SiriKitExampleIntentUI
//
//  Created by Henrique Gouveia on 8/3/16.
//  Copyright © 2016 CI&T. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Get Model from Data Provider

    private func fetchMessageIntent(string: String?) -> Item? {
        if let string = string {
            let fetchedResult = DataProvider.filterItem(itemDescription: string)
            if fetchedResult.count > 0 {
                if let item = fetchedResult.first {
                    return item
                }
            }
        }

        return nil
    }

    private func fillFields(item: Item) {
        self.itemImageView.image = UIImage(named: item.imageName)
        self.itemDescriptionLabel.text = "\(item.category) \(item.model) \(item.color)"
        self.itemPriceLabel.text = "R$ \(item.price)"
    }

    // MARK: - INUIHostedViewControlling

    // Prepare your view controller for the interaction to handle.
    func configure(with interaction: INInteraction!, context: INUIHostedViewContext, completion: ((CGSize) -> Void)!) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.

        if let messageIntent = interaction.intent as? INSendMessageIntent {
            if let item = self.fetchMessageIntent(string: messageIntent.content) {
                self.fillFields(item: item)
            }
        }

        if let completion = completion {
            completion(self.desiredSize)
        }
    }

    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
