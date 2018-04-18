import UIKit
import FirebaseDatabase
import FirebaseAuth

class EditViewController: UIViewController {
    var user: User!

    // define references to DB
    let ref = Database.database().reference(withPath: "Users")
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = self.user else { return }
            self.user = User(authData: user)
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        // save data into Database as json
        guard
            let name = nameTextField.text,
            let phone = phoneTextField.text,
            let address = addressTextField.text
        else {
                return
        }
        
        let userInfo = UserInfo(name: name,
                                //email: self.user.email,
                                phone: phone,
                                address: address)

        let userInfoRef = self.ref.child(name.lowercased())

        userInfoRef.setValue(userInfo.toAnyObject())

        // testing
        
        // go back to profile page
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
        //self.present(vc!, animated: true, completion: nil)
    }
}
