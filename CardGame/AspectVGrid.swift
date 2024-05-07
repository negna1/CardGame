//
//  AspectVGrid.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 07.05.24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, CardContent: View>: View {
    var items: [Item]
    var content: (Item) -> CardContent
    func siezTofit(count: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1.0
        let count = CGFloat(count)
        while(columnCount < count) {
            let paddingsWidth = (columnCount - 1)*6.0 + 6
            let width = (size.width/columnCount).rounded(.down) - paddingsWidth
            let height = width/aspectRatio
            let rowCount = count/columnCount.rounded(.up)
            if(rowCount*height < size.height) {
                return width
            }
            columnCount += 1
        }
        return 50
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            LazyVGrid(columns: [GridItem(.adaptive(
                minimum:
                    siezTofit(count: items.count,
                              size: geometry.size,
                              aspectRatio: 2/3) ))],spacing: 0,
                      content: {
                
                ForEach(items) { item in
                    content(item)
                }
            })
        })
    }
}
