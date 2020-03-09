import SwiftUI

struct ContentView: View {
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
    }

    
    var body: some View {
        NavigationView {
             TabView {
                SummaryView(viewModel: summaryVM)
                    .tabItem({Text("TableView").modifier(GeneralText(size:25))})
                    .tag("TableView")
                
                CollectionView(viewModel: summaryVM)
                    .tabItem({Text("CollectionView")
                    .modifier(GeneralText(size:25))})
                    .tag("CollectionView")
             }
             .padding(.top, -60)
             .accentColor(Color.black)
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
                                .padding(5)
                                .modifier(GeneralText(color: self.popularPage ? .black : .white))
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
                                .padding(5)
                                .modifier(GeneralText(color: self.recommendedPage ? .black : .white))
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
                                .padding(5)
                                .modifier(GeneralText(color: self.latestPage ? .black : .white))
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
                       index: self.currentMovie.index)
                .environmentObject(self.currentMovie)
        }
        .onAppear(perform: {
            // as soon as this View on screen
            self.summaryVM.fetchSummary(forType: 0)
        })
    }
}
