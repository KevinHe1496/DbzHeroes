//
//  PersonajesListViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 14/9/24.
//

import UIKit

final class PersonajesListViewController: UITableViewController {
    
    //MARK: - TableView DataSource
    // manejar los datos y proveer celdas al tableview
    // vamos a representar objetos de tipos Razas
    typealias DataSource = UITableViewDiffableDataSource<Int,DbzCharacter>
    // esto nos ayuda a actualizar los datos de la tabla
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, DbzCharacter>
    
    //MARK: - Model
    
    private let networkModel: NetworkModel
    // inicialmente este valor es nulo
    private var dataSource: DataSource?
    
    var searchController: UISearchController!
    
    private var allCharacters: [DbzCharacter] = []
    
    
    // MARK: Components
    // es la ruedita cuando esta cargando la vista
    private var activityIndicator: UIActivityIndicatorView {
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - initializers
    init(networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes"
        //        tableView.backgroundView = activityIndicator
        
        //1. registrar nuestra celda
        // registramos nuestro celda que creamos
        tableView.register(UINib(nibName: PersonajesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PersonajesTableViewCell.identifier)
        //2. configurar el data source
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, character in
            // Obtenemos una celda reusable y la casteamos
            //a el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonajesTableViewCell.identifier, for: indexPath) as? PersonajesTableViewCell else{
                // si  no puede desempaquetar
                // retornamos un uitableviewcell vacio
                return UITableViewCell()
            }
            
            cell.titleLabel.text = character.name
            cell.bodyLabel.text = character.description
            guard let url = URL(string: character.photo) else{
                print("ruta invalida")
                return UITableViewCell()
            }
            cell.personajeImageView.setImage(url: url)
            
            return cell
        }
        //3. añadir el data source al table view
        tableView.dataSource = dataSource
        //4. crear un snapshot con los objetos a representar
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        
        //5. aplicar el snapshot al data source para añadir los objetos
        networkModel.getAllCharacters { [weak self] result in
            
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
            }
            
            switch result{
                
            case let .success(character):
                
                self?.allCharacters = character
                
                DispatchQueue.main.async {
                    snapshot.appendItems(character)
                    self?.dataSource?.apply(snapshot)
                    self?.activityIndicator.stopAnimating()
                }
                
            case .failure(_):
                break
            }
        }
        configSearchBarController()
    }
    
    func configSearchBarController() {
        // Inicializamos el controlador de búsqueda sin una vista de resultados específica.
        searchController = UISearchController(searchResultsController: nil)
        
        // Asignamos el objeto actual como el actualizador de los resultados de la búsqueda.
        searchController.searchResultsUpdater = self
        
        // Asignamos el delegado de la barra de búsqueda para manejar eventos de la búsqueda.
        searchController.searchBar.delegate = self
        
        // Establecemos que la búsqueda no oscurezca el fondo durante la presentación.
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Establecemos el texto de marcador de posición (placeholder).
        searchController.searchBar.placeholder = "Buscar personaje"
        
        // Hacemos que la barra de búsqueda se oculte al hacer scroll.
        searchController.hidesNavigationBarDuringPresentation = false
        
        // Asignamos el controlador de búsqueda al item de navegación para que aparezca en la parte superior de la pantalla.
        navigationItem.searchController = searchController
        
        // Habilitamos la opción de que la barra de búsqueda no se oculte al hacer scroll.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Establecemos que el contexto de presentación esté definido.
        definesPresentationContext = true
    }


    
}

// MARK: - Table View Delagate
extension PersonajesListViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // aqui obtenemos el personaje seleccionado del datasource
        guard let selectedCharacter = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        
        // aqui instanciamos el DescriptionViewController y pasamos el personaje seleccionado
        let descriptionViewController = DescriptionViewController(character: selectedCharacter)
        
        // Navegar al nuevo controlador
        navigationController?.show(descriptionViewController, sender: self)
        
        
    }
}

// Extensión para conformar el controlador a los protocolos UISearchResultsUpdating y UISearchBarDelegate.
// Esto permite manejar la lógica de búsqueda en la barra de búsqueda integrada.
extension PersonajesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        // Verifica si el texto de búsqueda está disponible y no está vacío.
        // Si está vacío, muestra todos los personajes y termina la ejecución.
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            updateSnapshot(with: allCharacters) // Actualiza la tabla con todos los personajes.
            return
        }
        
        // Normaliza el texto de búsqueda eliminando acentos y pasando a minúsculas.
        let normalizedSearchText = normalize(searchText)
        
        // Filtra los personajes usando el texto normalizado.
        // Verifica si el nombre normalizado del personaje contiene el texto de búsqueda.
        let filteredCharacters = allCharacters.filter { character in
            normalize(character.name).contains(normalizedSearchText)
        }
        
        // Actualiza la tabla con los personajes filtrados.
        updateSnapshot(with: filteredCharacters)
    }

    // Función para normalizar un texto eliminando acentos y convirtiéndolo a minúsculas.
    private func normalize(_ text: String) -> String {
        // 'folding' elimina las marcas diacríticas (acentos, tildes) del texto.
        // 'lowercased()' convierte el texto a minúsculas para que la comparación sea insensible a mayúsculas.
        text.folding(options: .diacriticInsensitive, locale: .current).lowercased()
    }

    
    // Método privado para actualizar el DataSource con un nuevo snapshot de los personajes.
    private func updateSnapshot(with characters: [DbzCharacter]) {
        var snapshot = SnapShot() // Crea un nuevo snapshot.
        snapshot.appendSections([0]) // Añade una sección al snapshot.
        snapshot.appendItems(characters) // Añade los personajes filtrados a la sección.
        // Aplica el snapshot al DataSource, animando las diferencias para una transición suave.
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

