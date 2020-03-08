import SwiftUI

struct ContentView: View {
    let fetcher = MovieFetcher()
    @EnvironmentObject var summaryVM: SummaryVM
    //@ObservedObject var summaryVM: SummaryVM
    @EnvironmentObject var detailVM: DetailVM
    
    @State var section = 0
    @State var isLoading = true
    
    init() {


    }

    
    var body: some View {
        NavigationView {
//            if self.detailVM.movieId.count == 0 && self.summaryVM.movieId.count > 0{
//                    Text("").opacity(0).onAppear(perform: {
////                        self.detailVM.movieId = self.summaryVM.movieId
//                        //self.detailVM.fetchDetail()
//                    })
//                
//                
//            }
//            if isLoading {
//            Text("Loading\(detailVM.movieId.count)")
//                .onAppear(perform: {
//                    self.summaryVM.fetchSummary(forType: 0)
//                    withAnimation {
//                        self.isLoading.toggle()
//                    }
//                })
//            }
             TabView {  //selection: self.$selection
                SummaryView(viewModel: summaryVM)
                .tabItem({Text("TableView")})
                .tag("TableView")
////
                DetailView(viewModel: detailVM)
                .tabItem({Text("Detail")})
                .tag("Dtail")
//
//                SummaryView(viewModel: summaryVM)
//                .tabItem({Text("TableView")})
//                .tag("TableView")
            }
            .padding(.top, -60)

            .navigationBarTitle("\(summaryVM.movieId.count)")
            .navigationBarItems(trailing:
                HStack{
                    HStack {
                        Button(action: {
                            self.summaryVM.fetchSummary(forType: 0)
                        }) {
                            Text("Popular")
                                .modifier(GeneralText(color:Color.white))
                        }
                        Button(action: {
                            self.summaryVM.fetchSummary(forType: 1)
                        }) {
                            Text("Recommended")
                            .modifier(GeneralText(color:Color.white))
                        }
                        Button(action: {
                            self.summaryVM.fetchSummary(forType: 2)
                        }) {
                            Text("Latest")
                            .modifier(GeneralText(color:Color.white))
                        }
                    }
                }
            )
        }
    .onAppear(perform: {
        self.summaryVM.fetchSummary(forType: 0)
    })
    }
}
