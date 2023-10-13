//
//  ContentView.swift
//  SpreadSheetView
//
//  Created by Work on 13/10/2023.
//

import SwiftUI

// Vấn đề xảy ra khi dòng 3 cột 1 quá cao, còn dòng 3 cột 2 k giãn theo

struct Product: Hashable, Codable {
    
    var cost: Int
    var number: Int
    var color: String
    
    static let item1 = Product(cost: 500, number: 10, color: "XanhXanhXanhXanhXanhXanhXanhXanhXanhXanhXanhXanhXanh")
    static let item2 = Product(cost: 200, number: 20, color: "Đỏ")
    static let array = [item1, item2]
}

struct ProductTranslator {
    
    private static let jsonEncoder = JSONEncoder()
    typealias Dictionary = [String : Any]
    
    static func createDictionary(product: Product) -> Dictionary {
        
        if let jsonData = try? jsonEncoder.encode(product) {
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictionary = jsonObject as? Dictionary {
                return dictionary
            }
        }
        return [:]
    }
}

struct ContentView: View {
    
    let mirror1 = Mirror(reflecting: Product.item1).children
    let mirror2 = Mirror(reflecting: Product.item2).children
    
    
//    lazy var matrix = zip(values1, values2).map { [$0, $1] }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                //                VStack(alignment: .leading, spacing: 0) {
                //                    ForEach(labels, id: \.self) { label in
                //                        Text(label)
                //                    }
                //                }
                Rectangle()
                    .frame(width: 10)
                
                ForEach(Product.array, id: \.self) { product in
                    //                    VStack(alignment: .leading, spacing: 0) {
                    //                        ForEach(product.getValues(), id: \.self) { value in
                    //                            Text(value)
                    //                                .frame(width: 80)
                    //                                .background(Color.red)
                    //                        }
                    //                    }
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .onAppear {
                onAppear()
            }
        }
        .background(Color.green)
    }
    
    private func onAppear() {
        var labels = mirror1.compactMap {
            $0.label
        }
        
        var values1 = mirror1.map {
            $0.value
        }
        
        var values2 = mirror2.map {
            $0.value
        }
        let dict1 = ProductTranslator.createDictionary(product: Product.item1)
        let dict2 = ProductTranslator.createDictionary(product: Product.item2)
        labels.forEach { label in
            row(key: label, productArray: [dict1, dict2])
        }
    }
    
    private func row(key: String, productArray: [ProductTranslator.Dictionary]) {
        print("--- key ---  = ", key)
        productArray.forEach { dic in
            print("--- dict ---  = ", dic[key])
        }
    }
}

#Preview {
    ContentView()
}
