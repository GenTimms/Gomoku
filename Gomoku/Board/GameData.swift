import Foundation
    
typealias Intersection = (row: Int, column: Int)

class BoardFactoryImpl: BoardFactory {
    func makeBoard() -> Board & BoardState {
        return GameData()
    }
}


class GameData: Board, BoardState {
    
    var placedStones = [Int: Player]()
    var player = Player.white
    
    let width = 19
    let height = 19
    
    func stonesPlaced() -> Int {
        return placedStones.count
    }
    
    func takeTurn(at intersection: Intersection) -> BoardError? {
        let error =  place(at: intersection, by: player)
        player = other(player: player)
        return error
    }
    
    func other(player: Player) -> Player {
        return player == Player.white ? Player.black : Player.white
    }
    
    func makeLocation(at intersection: Intersection) -> (Int, BoardError?)  {
        var error: BoardError?
        let row = intersection.row
        let column = intersection.column
        
        if (row < 0 || row >= height) || (column < 0 || column >= width) {
            error = .badLocation
        }
        return (row * width + column,error)
    }
    
    func place(at intersection: Intersection, by player: Player) -> BoardError? {
        let (loc, error) = makeLocation(at: intersection)
        if error != nil { return error }
        if placedStones[loc] != nil {
            return .spaceOccupied
        }
        placedStones[loc] = player
        return nil
    }
    
    func get(at intersection: Intersection) -> (Player?, BoardError?) {
        let (loc, error) = makeLocation(at: intersection)
        if (error != nil) {
            return (nil, error)
        }
        if let stone = placedStones[loc] {
            return (stone, nil)
        } else {
            return (.empty, nil)
        }
    }
    

}
