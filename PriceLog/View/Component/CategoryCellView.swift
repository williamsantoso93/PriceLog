//
//  CategoryCellView.swift
//  PriceLog
//
//  Created by William Santoso on 23/10/22.
//

import SwiftUI

struct CategoryCellView: View {
    let title: String
    let onEdit: (() -> Void)?
    let onDelete: (() -> Void)?
    
    init(title: String, onEdit: (() -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.title = title
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(height: 100)
            Text(title)
        }
        .cornerRadius(10)
        .contextMenu {
            if let onEdit = onEdit {
                Button {
                    onEdit()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
            
            if let onDelete = onDelete {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(title: "Cereal")
    }
}
