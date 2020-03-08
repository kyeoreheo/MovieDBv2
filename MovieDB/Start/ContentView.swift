import SwiftUI

struct ContentView: View {
    let fetcher = MovieFetcher()
    @EnvironmentObject var summaryVM: SummaryVM
    @EnvironmentObject var detailVM: DetailVM
    @EnvironmentObject var commentVM: CommentVM
    @EnvironmentObject var currentMovie: CurrentMovie
    
    @State var section = 0
    @State var isLoading = true
    @State var showignDetail = false
    
    init() {

        //UITabBar.appearance().backgroundColor = UIColor.black
    }

    
    var body: some View {
        NavigationView {
             TabView {  //selection: self.$selection
                SummaryView(viewModel: summaryVM)
                    .tabItem({Text("TableView").modifier(GeneralText(size:25))})
                .tag("TableView")
                
                CollectionView(viewModel: summaryVM)
                    .tabItem({Text("CollectionView").modifier(GeneralText(size:25))})
                .tag("CollectionView")
            }
             .accentColor(Color.black)
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
                        Button(action: {
                            self.showignDetail.toggle()
                        }) {
                            Text("BTN")
                        }
                    }
                }
            )
        }
        .sheet(isPresented: self.$currentMovie.showingDetail ) {
            DetailView(summaryModel: self.summaryVM,
                       detailModel: self.detailVM,
                       commentModel: self.commentVM,
                       index: self.currentMovie.index).environmentObject(self.currentMovie)
        }
    .onAppear(perform: {
        self.summaryVM.fetchSummary(forType: 0)
    })
        
    }
}
