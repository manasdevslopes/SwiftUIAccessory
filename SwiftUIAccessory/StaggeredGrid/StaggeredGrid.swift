//
//  StaggeredGrid.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 17/12/21.
//

import SwiftUI

// Custom View Builder

// T -> is to hold the identifiable collection of data....
struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    // it will return each object from collection to build view
    var content: (T) -> Content
    var list: [T]
    
    var columns: Int
    
    // properties....
    var showIndicator: Bool
    var spacing: CGFloat
    
    init(columns: Int, showIndicator: Bool = false, spacing: CGFloat = 10, list: [T],@ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.list = list
        self.showIndicator = showIndicator
        self.spacing = spacing
        self.columns = columns
    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: showIndicator) {
            HStack(alignment: .top) {
                ForEach(setUpList(), id: \.self) { columnsData in
                    LazyVStack {
                        ForEach(columnsData){object in
                            content(object)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
    
    // Staggered Grid Function
    func setUpList()->[[T]] {
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        var currentIndex: Int = 0
        for object in list {
            gridArray[currentIndex].append(object)
            
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
