import UIKit
import FirebaseDatabase
import FirebaseAuth

class EditViewController: UIViewController {
    var user: Users!

    // define references to DB
    let ref = Database.database().reference()
    
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = Users(authData: user)
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        // save data into Database as json
        let email = self.user.getEmail
        guard
            let name = nameTextField.text,
            let phone = phoneTextField.text,
            let address = addressTextField.text
            else {
                return
        }
        
        self.ref.child("users").child(user.getUid).setValue(["email": email,
                                                             "name": name,
                                                             "phone": phone,
                                                             "address": address])
        
        // go back to profile page
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        // go back to profile page
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
        self.present(vc!, animated: true, completion: nil)
    }
    
   
}
