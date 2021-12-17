//
//  Home.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 17/12/21.
//

import SwiftUI

struct Home: View {
    @State var posts: [Post] = []
    @State var columns: Int = 2
    
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            StaggeredGrid(columns: columns, list: posts, content: {post in
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
            })
                .padding(.horizontal)
                .navigationBarTitle(Text("Staggered Grid"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            columns += 1
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            columns = max(columns - 1, 1)
                        }) {
                            Image(systemName: "minus")
                        }
                    }
                }
                .animation(.easeInOut, value: columns)
        }
        .onAppear {
            for index in 1...11 {
                posts.append(Post(imageURL: "Manas\(index)"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct PostCardView: View {
    var post: Post
    var body: some View {
        Image("\(post.imageURL)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
