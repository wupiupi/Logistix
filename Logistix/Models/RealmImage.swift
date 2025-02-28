import Foundation
import RealmSwift

class RealmImage: Object, Identifiable {
    @Persisted var id: String = UUID().uuidString
    @Persisted var imageID: String
    @Persisted var data: Data?
    
    convenience init(imageID: String, data: Data?) {
        self.init()
        self.imageID = imageID
        self.data = data
    }
}
