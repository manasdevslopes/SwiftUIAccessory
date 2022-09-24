  //
  //  TaskAnddotTask.swift
  //  SwiftUIAccessory
  //
  //  Created by MANAS VIJAYWARGIYA on 24/09/22.
  //

import SwiftUI

class TaskAnddotTaskViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  @Published var image2: UIImage? = nil
  
  func fetchImage() async {
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    
    for _ in 1...1_000 {
      /// Although in some cases, like long task it won't cancel immediately, in that use Task.checkCancellation() as shown in view model
      // some work
      try? Task.checkCancellation()
    }
    
    do {
      guard let url = URL(string: "https://picsum.photos/1000") else { return }
      let (data, _) = try await URLSession.shared.data(from: url)
      await MainActor.run(body: {
        self.image = UIImage(data: data)
        print("Image Fetched Successfully!")
      })
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func fetchImage2() async {
    do {
      guard let url = URL(string: "https://picsum.photos/1000") else { return }
      let (data, _) = try await URLSession.shared.data(from: url)
      await MainActor.run(body: {
        self.image2 = UIImage(data: data)
      })
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct TaskAnddotTaskHomeView: View {
  var body: some View {
    NavigationView {
      ZStack {
        NavigationLink("CLICK ME!🤓") {
          TaskAnddotTask()
        }
      }
    }
  }
}


struct TaskAnddotTask: View {
  @StateObject private var vm = TaskAnddotTaskViewModel()
  
    // To cancel the Task on moving back
    // First Step
  @State private var fetchImageTask: Task<(), Never>? = nil
  
  var body: some View {
    VStack(spacing: 40) {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
      }
      
      if let image = vm.image2 {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
      }
    }
    
    /*
     // Third Step
     .onDisappear {
     fetchImageTask?.cancel()
     }
     .onAppear {
     /* One way of calling it
      Task {
      await vm.fetchImage()
      await vm.fetchImage2()
      }
      */
     
     /* Second way of calling it
      //      Task {
      //        print(Thread.current)
      //        print(Task.currentPriority)
      //        await vm.fetchImage()
      //      }
      //      Task {
      //        print(Thread.current)
      //        print(Task.currentPriority)
      //        await vm.fetchImage2()
      //      }
      */
     
     /* Third way of calling it
      Task(priority: .high) {
      // try? await Task.sleep(nanoseconds: 2_000_000_000)
      await Task.yield()
      print("high: \(Thread.current) : \(Task.currentPriority)")
      }
      Task(priority: .userInitiated) {
      print("userInitiated: \(Thread.current) : \(Task.currentPriority)")
      }
      Task(priority: .medium) {
      print("medium: \(Thread.current) : \(Task.currentPriority)")
      }
      Task(priority: .low) {
      print("LOW: \(Thread.current) : \(Task.currentPriority)")
      }
      Task(priority: .utility) {
      print("utility: \(Thread.current) : \(Task.currentPriority)")
      }
      Task(priority: .background) {
      print("background: \(Thread.current) : \(Task.currentPriority)")
      }
      */
     
     /* Fourth way of calling Task - Task inside Task. Not appropriate by the way
      Task(priority: .userInitiated) {
      print("userInitiated: \(Thread.current) : \(Task.currentPriority)")
      
      Task {
      // It will give same prority value for first print and below print
      print("userInitiated2: \(Thread.current) : \(Task.currentPriority)")
      }
      
      // But if you want to give different priority than the parent Task
      // Use this
      Task.detached {
      print("detached: \(Thread.current) : \(Task.currentPriority)")
      }
      }
      */
     
     // Second Step
     self.fetchImageTask = Task {
     await vm.fetchImage()
     }
     }
     */
    
    /// Instead of using .onAppear , .onDisappear, Task
    /// use .task {} - it will handle both calling Task {} and also cancels it (.onDisappear() of a view)
    /// Although in some cases, like long task it won't cancel immediately, in that use Task.checkCancellation() as shown in view model
    .task {
      await vm.fetchImage()
    }
    
  }
}

struct TaskAnddotTask_Previews: PreviewProvider {
  static var previews: some View {
    TaskAnddotTask()
  }
}
