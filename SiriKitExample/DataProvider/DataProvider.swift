//
//  DataProvider.swift
//  SiriKitExample
//
//  Created by Henrique Gouveia on 8/3/16.
//  Copyright © 2016 CI&T. All rights reserved.
//

import Foundation

struct DataProvider {
    private var items: [Item] = []

    // MARK: Singleton

    static let sharedInstance = DataProvider()

    // MARK: Constructors

    init() {
        self.items = self.generateItems()
    }

    // MARK: Private Methods

    private func generateItems() -> [Item] {
        let tshirt1 = Item(id: 1, model: "Xadrez", color: "Azul", category: "Camisa", price: 139.90, imageName: "camisa-1")
        let tshirt2 = Item(id: 2, model: "Xadrez", color: "Verde", category: "Camisa", price: 139.90, imageName: "camisa-2")
        let tshirt3 = Item(id: 3, model: "Xadrez", color: "Vermelho", category: "Camisa", price: 139.90, imageName: "camisa-3")
        let shoes = Item(id: 4, model: "Corrida", color: "Marrom", category: "Tênis", price: 230.00, imageName: "tenis")
        let socialShoe = Item(id: 5, model: "Oxford", color: "Whisky", category: "Sapato", price: 400.00, imageName: "sapato")
        return [tshirt1,
                tshirt2,
                tshirt3,
                shoes,
                socialShoe]
    }

    private func filterByCategory(_ itemDescription: String, items: [Item]) -> [Item] {
        return items.filter { itemDescription.lowercased().contains($0.category.lowercased()) }
    }

    private func filterByModel(_ itemDescription: String, items: [Item]) -> [Item] {
        return items.filter { itemDescription.lowercased().contains($0.model.lowercased()) }
    }

    private func filterByColor(_ itemDescription: String, items: [Item]) -> [Item] {
        return items.filter { itemDescription.lowercased().contains($0.color.lowercased()) }
    }

    // MARK: Filters

    static func filterItem(itemDescription: String) -> [Item] {
        let filteredByCategory = self.sharedInstance.filterByCategory(itemDescription, items: self.sharedInstance.items)
        if filteredByCategory.count > 0 {
            let filteredByModel = self.sharedInstance.filterByModel(itemDescription, items: filteredByCategory)
            if filteredByModel.count > 0 {
                let filteredByColor = self.sharedInstance.filterByColor(itemDescription, items: filteredByModel)
                if filteredByColor.count > 0 {
                    return filteredByColor
                } else {
                    return filteredByModel
                }
            } else {
                return filteredByCategory
            }
        } else {
            let filteredByModel = self.sharedInstance.filterByModel(itemDescription, items: self.sharedInstance.items)
            if filteredByModel.count > 0 {
                let filteredByColor = self.sharedInstance.filterByColor(itemDescription, items: filteredByModel)
                if filteredByColor.count > 0 {
                    return filteredByColor
                } else {
                    return filteredByModel
                }
            }
        }

        return []
    }
}
