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
            self.nameLabel.text = value?["name"] as? String ?? ""
            self.emailLabel.text = value?["email"] as? String ?? ""
            self.addressLabel.text = value?["address"] as? String ?? ""
            self.phoneLabel.text = value?["phone"] as? String ?? ""
            
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
    
    @IBAction func checkButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Check")
        self.present(vc!, animated: true, completion: nil)
    }
   
    @IBAction func logoutButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Menu")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    
    }
    
}
