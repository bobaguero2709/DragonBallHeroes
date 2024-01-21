//
//  HeroListTableViewController.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/21/24.
//

import UIKit

final class HeroListTableViewController: UITableViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, DragonBallHero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, DragonBallHero>
    // MARK: - Model

    private let model: NetworkModel = .shared
    private var dataSource: DataSource?
    
    
    private var heroes: [DragonBallHero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tableView.register(
            UINib(nibName: HeroTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroTableViewCell.identifier)
        tableView.estimatedRowHeight = 100
        
        
        dataSource = DataSource(
            tableView: tableView) { tableView, indexPath, hero in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: HeroTableViewCell.identifier,
                    for: indexPath
                ) as? HeroTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: hero)
                return cell
        }
        
        tableView.dataSource = dataSource
        
        model.getHeroes { [weak self] result in
            switch result {
            case let .success(heroes):
                var snapshot = Snapshot()
                snapshot.appendSections([0])
                snapshot.appendItems(heroes)
                self?.dataSource?.apply(snapshot)
                self?.heroes = heroes
                
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
}

// MARK: - Configuration
private extension HeroListTableViewController {
    func setUpView() {
        title = "Heroes"
    }
}

// MARK: - Table View Delegate

extension HeroListTableViewController {
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            let hero = heroes[indexPath.row]
            let detailViewController = HeroDetailViewController(hero: hero)
            navigationController?.show(detailViewController,sender: nil)
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        300
    }
}
