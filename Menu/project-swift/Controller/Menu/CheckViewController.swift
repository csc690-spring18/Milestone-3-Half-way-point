import UIKit
import Firebase

class CheckViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func profileButton(_ sender: Any) {
        // check whether user has valid Auth session Firebase
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
                self.present(vc!, animated: true, completion: nil)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
    

    @IBAction func confirmButton(_ sender: Any) {
        // check whether user has valid Auth session Firebase
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {

                // check whether use fill in their info of profile
                let ref = Database.database().reference()
                let userID = Auth.auth().currentUser?.uid

                ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in

                    let value = snapshot.value as? NSDictionary
                    // user could check out if profile has enough info
                    if (value?["name"] as? String ?? "" != ""  &&
                        value?["address"] as? String ?? "" != "" &&
                        value?["phone"] as? String ?? "" != "") {

                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Confirm")
                        self.present(vc!, animated: true, completion: nil)

                    } else {
                        let alertController = UIAlertController(title: "Oops!", message: "Please complete Profile, we could contact and delivery to you!", preferredStyle: .alert)

                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)

                        self.present(alertController, animated: true, completion: nil)

                        //                        print("Testing")
                        //
                        //                        self.dismiss(animated: false) {
                        //                            // force user to go to edit page to fill in info of profile
                        //                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Edit")
                        //                            self.present(vc!, animated: true, completion: nil)
                        //                        }
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
  
    
}
