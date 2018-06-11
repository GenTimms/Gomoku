protocol BoardState {
    var width: Int { get }
    var height: Int { get }
    func get(at intersection: Intersection) -> (Player?, BoardError?)
}
