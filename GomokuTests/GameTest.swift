import XCTest
@testable import Gomoku

class GameTest: XCTestCase {
    
    var game: Game!
    
    override func setUp() {
        Game.boardFactory = BoardFactoryImpl()
        game = Game()
        super.setUp()
    }
 
    func testWhiteStartsNewGame() {

        XCTAssertEqual(Player.white, game.whoseTurn())
    }
    
    func testAfterATurn_isOtherPlayersTurn() {
        let turnPosition = Intersection(0,0)
        game.takeTurn(at: turnPosition)
        
        XCTAssertEqual(Player.white, game.board.get(at: turnPosition).0)
        XCTAssertEqual(Player.black, game.whoseTurn())
        
        let nextPlayerTurnPosition = Intersection(1,0)
        game.takeTurn(at: nextPlayerTurnPosition)
        
        XCTAssertEqual(Player.black, game.board.get(at: nextPlayerTurnPosition).0)
        XCTAssertEqual(Player.white, game.whoseTurn())
    }
}
