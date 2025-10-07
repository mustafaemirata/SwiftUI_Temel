import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var superKahramanIsimleri = [String]()
    var superKahramanGorselIsimleri = [String]()

    @IBOutlet weak var tablo: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablo.delegate = self
        tablo.dataSource = self
        
        superKahramanIsimleri.append(contentsOf: ["Batman", "Superman", "Spiderman", "Iron Man", "Captain America"])
        superKahramanGorselIsimleri.append(contentsOf: ["batman", "superman", "spiderman", "ironman", "captainamerica"])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superKahramanIsimleri.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = superKahramanIsimleri[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            superKahramanIsimleri.remove(at: indexPath.row)
            superKahramanGorselIsimleri.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsViewController", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            if let destinationVC = segue.destination as? DetailsViewController,
               let indexPath = sender as? IndexPath {
                destinationVC.secilenKahramanIsim = superKahramanIsimleri[indexPath.row]
                destinationVC.secilenKahramanGorsel = superKahramanGorselIsimleri[indexPath.row]
            }
        }
    }
}
