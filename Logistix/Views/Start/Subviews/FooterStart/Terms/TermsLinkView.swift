import SwiftUI

struct TermsLinkView: View {
    let title: String
    let stringURL: String
    
    var body: some View {
        
        Link(destination: URL(string: stringURL)!) {
            Text(title)
        }
        .fontWeight(.bold)
        .hAlign(.leading)
    }
}
