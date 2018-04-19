import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    // define references to DB
    let ref = Database.database().reference()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve cur user's info from Database
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // get user value
            let value = snapshot.value as? NSDictionary
            self.nameLabel.text =    "Name:      \(value?["name"] as? String ?? "")"
            self.emailLabel.text =   "Email:     \(value?["email"] as? String ?? "")"
            self.addressLabel.text = "Address:   \(value?["address"] as? String ?? "")"
            self.phoneLabel.text =   "Phone #:   \(value?["phone"] as? String ?? "")"

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Edit")
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backHomeButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        self.present(vc!, animated: true, completion: nil)
    }
}
