//
//  ContentView.swift
//  SpreadSheetView
//
//  Created by Work on 13/10/2023.
//

import SwiftUI

// Vấn đề xảy ra khi dòng 3 cột 1 quá cao, còn dòng 3 cột 2 k giãn theo

struct Product: Hashable {
    
    var cost: Int
    var number: Int
    var color: String
    
    static let item1 = Product(cost: 500, number: 10, color: "XanhXanhXanhXanhXanhXanhXanhXanhXanhXanhXanhXanhXanh")
    static let item2 = Product(cost: 200, number: 20, color: "Đỏ")
    static let array = [item1, item2]
    
    func getValues() -> [String] {
        Mirror(reflecting: self)
            .children
            .compactMap { $0.value }
            .map { any in
                String(describing: any)
            }
    }
}

struct ContentView: View {
    
    var labels: [String] {
        Mirror(reflecting: Product.item1).children.compactMap { $0.label }
    }
    
    
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(labels, id: \.self) { label in
                        Text(label)
                    }
                }
                Rectangle()
                    .frame(width: 10)
                
                ForEach(Product.array, id: \.self) { product in
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(product.getValues(), id: \.self) { value in
                            Text(value)
                                .frame(width: 80)
                                .background(Color.red)
                        }
                    }
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .background(Color.green)
    }
}

#Preview {
    ContentView()
}
