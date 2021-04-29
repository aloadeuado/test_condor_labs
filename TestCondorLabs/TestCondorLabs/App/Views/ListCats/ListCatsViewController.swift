//
//  ViewController.swift
//  TestExito
//
//  Created by Pedro Alonso Daza B on 15/02/21.
//

import UIKit
import TTGSnackbar

class ListCatsViewController: UIViewController {

    @IBOutlet weak var searchItemView: SearchBarView!
    @IBOutlet weak var catsTableView: UITableView!
    
    var isLoading = false
    var initListCats = [CatModel]()
    var listCats = [CatModel]()
    var selectCat: CatModel?
    var listCatsViewModel: ListCatsViewModel?
    let limit = 10
    var page = 0
    let rateCall: CGFloat = 700
    var isCallService = true
    var isFullPageCall = false
    var limitSkeletor = 3
    override func viewDidLoad() {
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initComponent()
    }
    
    func initComponent(){
        listCatsViewModel = ListCatsViewModel(listCatsViewModelDelegate: self)
        listCatsViewModel?.getListCats(limit: limit, page: page)
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
        return (isLoading) ? limitSkeletor : listCats.count + limitSkeletor
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListCatsTableiViewCell{
            if isLoading {
                cell.showSkeletor()
            } else {
             
                print("==index: \(indexPath.row)")
                if indexPath.row > (self.listCats.count - 1) {
                    cell.showSkeletor()
                } else {
                    cell.generalView.stopShimmeringAnimation()
                    cell.setData(catModel: self.listCats[indexPath.row]) { (catModel) in
                        self.selectCat = catModel
                        self.performSegue(withIdentifier: "showDetailCat", sender: nil)
                    }
                    
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
        self.selectCat = listCats[indexPath.row]
        self.performSegue(withIdentifier: "showDetailCat", sender: nil)
    }
}

//MARK: -ListCatsViewModelDelegate
extension ListCatsViewController: ListCatsViewModelDelegate{
    func error(error: String) {
        let snackbar = TTGSnackbar(message: error, duration: .short)
        snackbar.show()
        isLoading = false
        isCallService = true
        catsTableView.reloadData()
    }
    
    func successgetListCats(succesGetCat listCats: [CatModel]) {
        if listCats.count < limit {
            isFullPageCall = true
        }
        self.initListCats.append(contentsOf: listCats)
        self.listCats = self.initListCats 
        isLoading = false
        isCallService = true
        catsTableView.reloadData()
    }
    
    
}
//MARK: -SearchItemViewDelegate
extension ListCatsViewController: SearchBarViewDelegate{
    func searchBarView(didEdintingText text: String) {
        self.listCats = listCatsViewModel?.filterCats(text: text, listCats: self.initListCats) ?? [CatModel]()
        catsTableView.reloadData()
    }
    
    func searchBarView(didClearText textBeforeClear: String) {
        self.listCats = self.initListCats
        catsTableView.reloadData()
    }
    
    /*func fetchField(text: String) {
        self.listCats = listCatsViewModel?.filterCats(text: text, listCats: self.initListCats) ?? [CatModel]()
        catsTableView.reloadData()
    }*/
    
    
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

extension ListCatsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (catsTableView.contentSize.height - rateCall) {
            if !isFullPageCall && isCallService {
                page += 1
                listCatsViewModel?.getListCats(limit: limit, page: page)
                isCallService = false
            }
        }
    }
}


