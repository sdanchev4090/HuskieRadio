//
//  SongHistoryViewController.swift
//  HuskieRadio
//
//  Created by Amanda Reyes on 12/19/22.
//

import UIKit

class SongHistoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var songsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songsTable.dataSource = self
        songsTable.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
