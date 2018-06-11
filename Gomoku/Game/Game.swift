protocol BoardFactory {
    func makeBoard() -> Board & BoardState
}

class Game {
    
    let board: Board & BoardState
    let rules: GomokuRules
    static var boardFactory : BoardFactory!

    init() {
        self.board = Game.boardFactory.makeBoard()
        self.rules = GomokuRules()
    }
    
    func takeTurn(at intersection: Intersection) -> BoardError? {
            return board.takeTurn(at: intersection)
        }
    
    func getBoard() -> Board & BoardState {
        return board
    }
    
    func getRules() -> GomokuRules {
        return rules
    }
    
    func whoseTurn() -> Player {
        return board.player
    }
}
