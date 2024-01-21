//
//  HeroTransformationTableViewController.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/21/24.
//

import UIKit

final class HeroTransformationTableViewController: UITableViewController {

    typealias DataSource = UITableViewDiffableDataSource<Int, HeroTransformation>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, HeroTransformation>
    
    // MARK: - Model
    private let transformations: [HeroTransformation]
    private var dataSource: DataSource?
    
    // MARK: - Initializers
    init(transformations: [HeroTransformation]){
        self.transformations = transformations
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tableView.register(
            UINib(nibName: HeroTransformationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroTransformationTableViewCell.identifier)
        tableView.estimatedRowHeight = 100
        
        
        dataSource = DataSource(
            tableView: tableView) { tableView, indexPath, transformation in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: HeroTransformationTableViewCell.identifier,
                    for: indexPath
                ) as? HeroTransformationTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: transformation)
                return cell
        }
        
        tableView.dataSource = dataSource
       
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(transformations)
        dataSource?.apply(snapshot)
        
    }
    
    
}

// MARK: - Configuration
private extension HeroTransformationTableViewController {
    func setUpView() {
        title = "Transformaciones"
    }
}

// MARK: - Table View Delegate

extension HeroTransformationTableViewController {
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            let transformation = transformations[indexPath.row]
            let detailViewController = HeroTransformationDetailViewController(heroTransformation: transformation)
            navigationController?.show(detailViewController,sender: nil)
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        360
    }
}
