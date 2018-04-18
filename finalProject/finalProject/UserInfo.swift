import Foundation
import Firebase

struct UserInfo {

    let key: String
    let name: String
//    let email: String
    let phone: String
    let address: String
    let ref: DatabaseReference?

    public init(name: String,  phone: String, address: String, key: String = "") {
        self.key = key
        self.name = name
//        self.email = email
        self.phone = phone
        self.address = address
        self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
//        email = snapshotValue["email"] as! String
        phone = snapshotValue["phone"] as! String
        address = snapshotValue["address"] as! String
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
            "name": name,
//            "email": email,
            "phone": phone,
            "address": address
        ]
    }

}


//struct UserInfo {
//
//    let key: String
//    let name: String
//    let addedByUser: String
//    let ref: DatabaseReference?
//    var completed: Bool
//
//    init(name: String, addedByUser: String, completed: Bool, key: String = "") {
//        self.key = key
//        self.name = name
//        self.addedByUser = addedByUser
//        self.completed = completed
//        self.ref = nil
//    }
//
//    init(snapshot: DataSnapshot) {
//        key = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        name = snapshotValue["name"] as! String
//        addedByUser = snapshotValue["addedByUser"] as! String
//        completed = snapshotValue["completed"] as! Bool
//        ref = snapshot.ref
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "name": name,
//            "addedByUser": addedByUser,
//            "completed": completed
//        ]
//    }
//
//}

