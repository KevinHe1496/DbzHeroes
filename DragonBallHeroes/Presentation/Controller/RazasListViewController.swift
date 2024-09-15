//
//  RazasListViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 14/9/24.
//

import UIKit

final class RazasListViewController: UITableViewController {
    
    //MARK: - TableView DataSource
    // manejar los datos y proveer celdas al tableview
    // vamos a representar objetos de tipos Razas
    typealias DataSource = UITableViewDiffableDataSource<Int,Razas>
    // esto nos ayuda a actualizar los datos
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Razas>
    
    //MARK: - Model
    // es nuestro array de razas
    private let razas: [Razas] = Razas.allCases
    // inicialmente este valor es nulo
    private var dataSource: DataSource?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. registrar nuestra celda
        // registramos nuestro celda que creamos
        tableView.register(UINib(nibName: RazasTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RazasTableViewCell.identifier)
        //2. configurar el data source
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, raza in
            // Obtenemos una celda reusable y la casteamos
            //a el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RazasTableViewCell.identifier, for: indexPath) as? RazasTableViewCell else{
                // si  no puede desempaquetar
                // retornamos un uitableviewcell vacio
                return UITableViewCell()
            }
            
            cell.configure(with: raza)
            return cell
        }
        //3. añadir el data source al table view
        tableView.dataSource = dataSource
        //4. crear un snapshot con los objetos a representar
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(razas)
        
        //5. aplicar el snapshot al data source para añadir los objetos
        dataSource?.apply(snapshot)
        
    }
    
}


extension RazasListViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
