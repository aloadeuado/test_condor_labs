//
//  ViewController.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 15/02/21.
//

import UIKit
import TTGSnackbar

class ListCatsViewController: UIViewController {

    @IBOutlet weak var searchItemView: SearchItemView!
    @IBOutlet weak var catsTableView: UITableView!
    
    var isLoading = false
    var listCats = [CatModel]()
    var initListCats = [CatModel]()
    var selectCat: CatModel?
    var listCatsViewModel: ListCatsViewModel?
    override func viewDidLoad() {
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initComponent()
    }
    
    func initComponent(){
        listCatsViewModel = ListCatsViewModel(listCatsViewModelDelegate: self)
        listCatsViewModel?.getListCats(controller: self)
        isLoading = true
        catsTableView.reloadData()
        searchItemView.delegate = self
    }


}
//MARK: -UITableViewDataSource
extension ListCatsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isLoading) ? 3 : listCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListCatsTableiViewCell{
            if isLoading{
                cell.generalView.startShimmeringAnimation()
            } else{
                cell.generalView.stopShimmeringAnimation()
                cell.setData(catModel: listCats[indexPath.row]) { (catModel) in
                    self.selectCat = catModel
                    self.performSegue(withIdentifier: "showDetailCat", sender: nil)
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
//MARK: -UITableViewDelegate
extension ListCatsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: -ListCatsViewModelDelegate
extension ListCatsViewController: ListCatsViewModelDelegate{
    func error(error: String) {
        let snackbar = TTGSnackbar(message: error, duration: .short)
        snackbar.show()
        isLoading = false
        catsTableView.reloadData()
    }
    
    func successgetListCats(succesGetCat listCats: [CatModel]) {
        self.listCats = listCats
        self.initListCats = listCats
        catsTableView.reloadData()
        isLoading = false
        catsTableView.reloadData()
    }
    
    
}
//MARK: -SearchItemViewDelegate
extension ListCatsViewController: SearchItemViewDelegate{
    func fetchField(text: String) {
        self.listCats = listCatsViewModel?.filterCats(text: text, listCats: self.initListCats) ?? [CatModel]()
        catsTableView.reloadData()
    }
    
    
}

extension ListCatsViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detailCatViewController = segue.destination as? DetailCatViewController{
            detailCatViewController.selectCat = self.selectCat
        }
    }
}


