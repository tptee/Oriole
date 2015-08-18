import UIKit
import Oriole

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		print([4, 8, 15, 16, 23, 42].chunk(2))
		print([4, 8, 15, 16, 23, 42].every {$0 == 23})
		print([42, 42, 42, 42].every {$0 == 42})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

