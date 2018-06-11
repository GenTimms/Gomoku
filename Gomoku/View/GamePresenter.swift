import Foundation

class GamePresenter {
    var playerTurnNames = [Player.white: "White's Turn", Player.black: "Black's Turn", Player.empty: "TILT"]
    var winStatusStrings = [Player.white: "White Wins!", Player.black: "Black Wins!", Player.empty: "TILT"]
    
    func getPlayerStatus(for player: Player) -> String {
        return playerTurnNames[player]!
    }
    
    func getWinStatus(for player: Player) -> String {
        return winStatusStrings[player]!
    }
    
}
