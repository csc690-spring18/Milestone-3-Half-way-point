

import UIKit

class ViewController: UIViewController {

    var productTypeArr:[String] = []
    var productNameArr:[AnyObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "balabala restaurant"
        self.view.backgroundColor = UIColor.white
        self.initData()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func  initData()
    {
        let path:String = (Bundle.main.path(forResource: "MenuData", ofType: "json"))!
        let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let json:AnyObject = try!JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
        let resultDict = json.object(forKey: "data") as! Dictionary<String,AnyObject>
        let productMenuArr:[AnyObject] = resultDict["productType"] as! Array
        for i:Int in 0 ..< productMenuArr.count
        {
            productTypeArr.append(productMenuArr[i]["typeName"] as! String)
            productNameArr.append(productMenuArr[i]["productName"] as! [String] as AnyObject)
        }
        
        self.addSubView()
    }

    
    func addSubView(){
        let classifyTable = GroupTableView(frame: CGRect(x: 0,y: 64,width: screenWidth,height: screenHeight-64), MenuTypeArr: productTypeArr, proNameArr: productNameArr)
        self.view.addSubview(classifyTable)
    }

}

