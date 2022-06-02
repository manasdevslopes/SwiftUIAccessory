  //
  //  WhatsAppImageExpand.swift
  //  SwiftUIAccessory
  //
  //  Created by MANAS VIJAYWARGIYA on 02/06/22.
  //

import SwiftUI

struct WhatsAppImageExpand: View {
  @Namespace private var animation
  @State var isExpanded: Bool = false
  @State var expandedProfile: Profile?
  @State var loadExpandedContent: Bool = false
  
  @State var offset: CGSize = .zero
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          ForEach(profiles) { profile in
            RowView(profile: profile)
          }
        }
        .padding()
      }
      .navigationTitle("WhatsApp")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .overlay {
      Rectangle()
        .fill(.black)
        .opacity(loadExpandedContent ? 1 : 0)
        .opacity(offsetProgress())
        .ignoresSafeArea()
    }
    .overlay {
      if let expandedProfile = expandedProfile, isExpanded {
        ExpandedView(profile: expandedProfile)
      }
    }
  }
}

extension WhatsAppImageExpand {
  // Offset Progress
  func offsetProgress() -> CGFloat {
    let progress = offset.height / 100
    if offset.height < 0 {
      return 1
    } else {
      return 1 - (progress < 1 ? progress : 1)
    }
  }
  
    // Expanded View
  @ViewBuilder
  func ExpandedView(profile: Profile) -> some View {
    VStack {
      GeometryReader { geo in
        let size = geo.size
        
        Image(profile.profilePicture)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size.width, height: size.height)
          .cornerRadius(loadExpandedContent ? 0 : size.height)
          .offset(y: loadExpandedContent ? offset.height : .zero)
          .gesture(
            DragGesture()
              .onChanged({ value in
                if value.translation.height >= 0 {
                  offset = value.translation
                }
              })
              .onEnded({ value in
                let height = value.translation.height
                if height > 0 && height > 100 {
                  withAnimation(.easeInOut(duration: 0.4)) {
                    loadExpandedContent = false
                  }
                  withAnimation(.easeInOut(duration: 0.4).delay(0.05)) {
                    isExpanded = false
                  }
                  // Resetting After Animation Completes
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    offset = .zero
                  }
                } else {
                  withAnimation(.easeInOut(duration: 0.4)) {
                    offset = .zero
                  }
                }
              })
          )
      }
      .matchedGeometryEffect(id: profile.id, in: animation)
      .frame(height: 300)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(alignment: .top, content: {
      HStack(spacing: 10) {
        Button {
          withAnimation(.easeInOut(duration: 0.4)) {
            loadExpandedContent = false
          }
          withAnimation(.easeInOut(duration: 0.4).delay(0.05)) {
            isExpanded = false
          }
        } label: {
          Image(systemName: "arrow.left")
            .font(.title3)
            .foregroundColor(.white)
        }

        Text(profile.userName)
          .fontWeight(.semibold)
          .foregroundColor(.white)
        
        Spacer(minLength: 10)
      }
      .padding()
      .opacity(loadExpandedContent ? 1 : 0)
      .opacity(offsetProgress())
    })
      // for more clean transition use transition with offset
    .transition(.offset(x: 0, y: 1))
    .onAppear {
      withAnimation(.easeInOut(duration: 0.4)) {
        loadExpandedContent = true
      }
    }
  }
  
    // Profile Row
  @ViewBuilder
  func RowView(profile: Profile) -> some View {
    HStack(spacing: 12) {
      VStack {
        if expandedProfile?.id == profile.id && isExpanded {
          Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 45, height: 45)
            .cornerRadius(0)
            .opacity(0)
        } else {
          Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 45, height: 45)
            .matchedGeometryEffect(id: profile.id, in: animation)
            .cornerRadius(25)
        }
      }
      .onTapGesture {
        withAnimation(.easeInOut(duration: 0.4)) {
          isExpanded = true
          expandedProfile = profile
        }
      }
      
      VStack(alignment: .leading, spacing: 6) {
        Text(profile.userName)
          .font(.callout)
          .fontWeight(.semibold)
        
        Text(profile.lastMsg)
          .font(.caption2)
          .foregroundColor(.gray)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(profile.lastActive)
        .font(.caption2)
        .foregroundColor(.gray)
    }
  }
}
struct WhatsAppImageExpand_Previews: PreviewProvider {
  static var previews: some View {
    WhatsAppImageExpand()
  }
}
