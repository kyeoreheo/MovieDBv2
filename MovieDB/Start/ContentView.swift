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
    
    @State var popularPage = true
    @State var recommendedPage = false
    @State var latestPage = false

    
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
                    .tabItem({Text("CollectionView")
                    .modifier(GeneralText(size:25))})
                    .tag("CollectionView")
             }
             .accentColor(Color.black)
             .padding(.top, -60)
                

             .navigationBarTitle("MovieDB")
             .navigationBarItems(trailing:
                HStack{
                    HStack {
                        Button(action: {
                            self.summaryVM.fetchSummary(forType: 0)

                            withAnimation{
                                self.popularPage = true
                                self.recommendedPage = false
                                self.latestPage = false
                            }
                        }) {
                            Text("Popular")
                                .modifier(GeneralText(color: self.popularPage ? .black : .white))
                            .padding(5)
                                .background(self.popularPage ? Color.white : MyColor.darkGray)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.summaryVM.fetchSummary(forType: 1)

                            withAnimation{
                                self.popularPage = false
                                self.recommendedPage = true
                                self.latestPage = false
                            }
                        }) {
                            Text("Recommended")
                            .modifier(GeneralText(color: self.recommendedPage ? .black : .white))
                            .padding(5)
                                .background(self.recommendedPage ? Color.white : MyColor.darkGray)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.summaryVM.fetchSummary(forType: 2)

                            withAnimation{
                                self.popularPage = false
                                self.recommendedPage = false
                                self.latestPage = true
                            }
                        }) {
                            Text("Latest")
                            .modifier(GeneralText(color: self.latestPage ? .black : .white))
                            .padding(5)
                                .background(self.latestPage ? Color.white : MyColor.darkGray)
                            .cornerRadius(10)
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
