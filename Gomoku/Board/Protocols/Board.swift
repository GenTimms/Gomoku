protocol Board {
    
    var width: Int { get }
    var height: Int { get }
    var player: Player { get set }
    
    func get(at intersection: Intersection) -> (Player?, BoardError?)
    func takeTurn(at: Intersection) -> BoardError?
    func place(at: Intersection, by: Player) -> BoardError?

}
