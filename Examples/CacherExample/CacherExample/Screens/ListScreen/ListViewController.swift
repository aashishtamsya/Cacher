//
//  ListViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView!
  
  fileprivate var datasource: [URL]?

  static func listViewController() -> ListViewController {
    return UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "ListImageCell", bundle: nil), forCellReuseIdentifier: "ListImageCell")
    
    datasource = [
    URL(string: "https://cdn.pixabay.com/photo/2018/06/11/17/02/flower-3468846_960_720.jpg"),
    URL(string: "https://interactive-examples.mdn.mozilla.net/media/examples/grapefruit-slice-332-332.jpg"),
    URL(string: "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
    URL(string: "https://images.unsplash.com/photo-1561320349-6f825f79edc3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    URL(string: "https://images.unsplash.com/photo-1561320637-607b6b19f493?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    URL(string: "https://images.unsplash.com/photo-1561318160-2273fd6f2924?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    URL(string: "https://images.unsplash.com/photo-1561282218-953afa0068e9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    URL(string: "https://images.unsplash.com/photo-1561254293-61222d29be71?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    URL(string: "https://images.unsplash.com/photo-1561252691-db1e375b4868?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60")
      ].compactMap({ return $0 })
  }
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return datasource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListImageCell") as! ListImageCell
    cell.bind(datasource?[indexPath.row])
    return cell
  }
}

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? ListImageCell else { return }
    cell.cancelLoading()
  }
}
