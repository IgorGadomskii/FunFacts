

import UIKit

class FunFactViewController: UIViewController {

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchText()
    }
    
    @IBAction func moreFactsButtonSelected(_ sender: Any) {
       fetchText()
    }
    
    
    @IBAction func okButtonSelected(_ sender: Any) {
    }
    

    
    private func fetchText() {
        guard
            let url = URL(string: "https://uselessfacts.jsph.pl/random.json?language=en")
        else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let funFact = try JSONDecoder().decode(FunFact.self, from: data)
                DispatchQueue.main.async {
                    self.funFactLabel.text = funFact.text
                    self.activityIndicator.stopAnimating()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
