//
//  StoreScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 01/11/22.
//

import Foundation
import CoreData


class StoreScreenViewModel: ObservableObject {
    @Published private var _storesVM: [StoreViewModel] = []
    var storesVM: [StoreViewModel] {
        _storesVM
    }
    
    @Published var name: String = ""
    
    func getStoreCD() {
        DispatchQueue.main.async {
            self._storesVM = StoreCD.getAllSortedByName().map(StoreViewModel.init)
        }
    }
    
    func saveStore() {
        let storeCD = StoreCD.init(context: StoreCD.viewContext)
        
        storeCD.id = UUID()
        storeCD.name = name
        
        do {
            try storeCD.save()
            name = ""
            getStoreCD()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteStore(at offsets: IndexSet) {
        for offset in offsets {
            let storeVM = storesVM[offset]
            
            deleteStore(by: storeVM.id)
        }
    }
    
    func deleteStore(by id: NSManagedObjectID) {
        if let store: StoreCD = StoreCD.byId(id: id) {
            do {
                try store.delete()
                getStoreCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for store in _storesVM {
            do {
                try store.delete()
            } catch {
                print(error.localizedDescription)
            }
        }
        getStoreCD()
    }
}

struct StoreViewModel: Identifiable {
    let storeCD: StoreCD
    
    init(storeCD: StoreCD) {
        self.storeCD = storeCD
    }
    
    var id: NSManagedObjectID {
        storeCD.objectID
    }
    
    var store: Store {
        Store(
            id: storeCD.id ?? UUID(),
            name: storeCD.name ?? ""
        )
    }
    
    func delete() throws {
        try storeCD.delete()
    }
}
