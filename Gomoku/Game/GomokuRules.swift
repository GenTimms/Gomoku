class GomokuRules {
    
    let winLength = 5
    
    func isWin(on board: BoardState, for player: Player) -> Bool {
        return isRowWin(on: board, for: player) || isColWin(on: board, for: player)
    }
    
    func isRowWin(on board: BoardState, for player: Player) -> Bool {
        return isConsecutive(board: board, player: player, iMax: board.height, jMax: board.width) { row, col in
            return board.get(at: Intersection(row, col)).0 }
    }
    
    func isColWin(on board: BoardState, for player: Player) -> Bool {
        return isConsecutive(board: board, player: player, iMax: board.width, jMax: board.height) { row, col in
            return board.get(at: Intersection(col, row)).0 }
    }

    func isConsecutive(board: BoardState, player: Player, iMax: Int, jMax: Int, getStone: (Int, Int) -> Player?) -> Bool {
        var consecutiveStones = ConsecutiveStones(with: winLength, for: player)
        for i in 0...iMax {
            for j in 0..<jMax {
                let playerPiece = getStone(i , j)
                    if consecutiveStones.update(with: playerPiece).isWin {
                        return true
                }
            }
        }
        return false
    }
}

struct ConsecutiveStones {
    var count = 0
    let winLength: Int
    let player: Player
    
    init(with winLength: Int, for player: Player) {
        self.winLength = winLength
        self.player = player
    }
    
    var isWin: Bool {
        return count >= winLength
    }
    
    mutating func update(with playerPiece: Player?) -> ConsecutiveStones  {
        count = playerPiece == player ? count + 1 : 0
        return self
    }
}

