//
//  HomeViewModel.swift
//  Matule
//
//  Created by Вадим Мартыненко on 13.05.2024.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    @Published private var entites: [ProductEntity] = []
    @Published var products: [ProductModel] = []
    
    private let container: NSPersistentContainer
    
    init() {
        self.container = .init(name: "DataModel")
        self.container.loadPersistentStores { description, error in
            
        }
        
        startUsingCoreData()
    }
    
    func fetchProducts() {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        
        do {
            let entities = try self.container.viewContext.fetch(request)
            
            self.entites = entities
            
            let products: [ProductModel] = entities.compactMap { entity in
                guard let id = entity.id,
                      let name = entity.name,
                      let img = entity.img else { return nil }
            
                return ProductModel(id: id, name: name, img: img, isHeart: entity.isHeart, price: Int(entity.price))
            }
            
            self.products = products
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func startUsingCoreData() {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        
        do {
            let entities = try self.container.viewContext.fetch(request)
            
            if entities.isEmpty {
                Constants.products.forEach { product in
                    addProduct(product: product)
                }
            } else {
                fetchProducts()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addProduct(product: ProductModel) {
        let entity = ProductEntity(context: self.container.viewContext)
        entity.id = product.id
        entity.img = product.img
        entity.name = product.name
        entity.isHeart = product.isHeart
        entity.price = Int16(product.price)
        
        save()
    }
    
    func toggleHeart(id: String) {
        print("start")
        print(id)
        guard let index = self.entites.firstIndex(where: { entity in
            print(entity.id ?? "nil")
            return entity.id == id
        }) else { return }
        print("change")
        entites[index].isHeart = !entites[index].isHeart
        print("save")
        save()
    }
    
    private func save() {
        do {
            try self.container.viewContext.save()
            fetchProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
}
