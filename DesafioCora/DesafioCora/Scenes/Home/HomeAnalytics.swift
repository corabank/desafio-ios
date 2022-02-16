import Foundation

enum HomeAnalytics: AnalyticsEventing {
    case viewed
    
    var name: String {
        return Name.viewed
    }
    
    var context: String {
        Context.login
    }
}
 
private extension HomeAnalytics {
    enum Name {
        static var viewed: String = "Home - Tela Apresentada"
    }
    
    enum Context {
        static var login: String = "HomeContext"
    }
}
