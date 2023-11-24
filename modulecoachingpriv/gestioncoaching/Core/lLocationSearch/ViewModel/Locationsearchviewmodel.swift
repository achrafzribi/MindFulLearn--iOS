//
//  Locationsearchviewmodel.swift
//  modulecoachingpriv
//
//  Created by Apple Esprit on 8/11/2023.
//
import Foundation
import MapKit

class Locationsearchviewmodel : NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
    @Published var coachs = [String]()
    @Published var selected :User?
    @Published var resultcoachs = [String]()
    @Published var selectedLocationCoordinate:CLLocationCoordinate2D?
    @Published var selectedcoach:String?
    @Published var coachusername:String = "Marker lol"
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            print("DEBUG: Query fragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
            resultcoachs = coachs.filter { coachName in
                return coachName.range(of: queryFragment, options: .caseInsensitive) != nil
            }
        }
    }
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
        coachs.append("Marker Title")
        coachs.append("Marker iheb")
        coachs.append("tuniss marsaa")
        
    }
    func selectLocation (_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch){
            response,error in
            if let error = error {
                print(" DEBUG: Location search failed with error\(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG: Location coordinates (coordinate)")
        }
        
    }
    func locationSearch (forLocalSearchCompletion localSearch: MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending (localSearch.subtitle)
       let   search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler : completion)
    }
    
    func selectLocationcoach (_ coachselected :String) {
        selectedLocationCoordinate = nil
        print(coachselected)
        selectedcoach = coachselected
        
}
}
extension Locationsearchviewmodel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
        
    }
}
