
import XCTest
@testable import Gomoku

class GomokuRulesTest: XCTestCase {
    var board: Board!
    var boardState: BoardState!
    var rules: GomokuRules!
    
    override func setUp() {
        Game.boardFactory = BoardFactoryImpl()
        board = Game.boardFactory.makeBoard()
        boardState = board as! BoardState
        rules = GomokuRules()
        super.setUp()
    }
    
    func testEmptyBoard_isNotWin()  {
        XCTAssertFalse(rules.isWin(on: boardState, for: Player.white))
    }
    
    func testNotEmptyBoardButNotWin_IsNotAWin() {
        _ = board.place(at: Intersection(1,1), by: Player.white)
        XCTAssertFalse(rules.isWin(on: boardState, for: Player.white))
    }
    
    func testFiveInARowInTheFirstRow_isAWin()  {
        for column in 0..<5 {
           _ = board.place(at: Intersection(0, column), by: Player.black)
        }
        XCTAssertTrue(rules.isWin(on: boardState, for: Player.black))
    }
    
    func testFiveConsecutiveStonesForAPlayer_isALose() {
        for column in 0..<5 {
            _ = board.place(at: Intersection(0, column), by: Player.black)
        }
        XCTAssertFalse(rules.isWin(on: boardState, for: Player.white))
    }
    
    
    func testFourInARowInTheFirstRow_isNotAWin()  {
        for column in 0..<4 {
            _ = board.place(at: Intersection(0, column), by: Player.white)
        }
        XCTAssertFalse(rules.isWin(on: boardState, for: Player.white))
    }
    
    func testSixInARowInTheFirstRow_isAWin() {
        for column in 0..<6 {
           _ = board.place(at: Intersection(0, column), by: Player.white)
        }
        XCTAssertTrue(rules.isWin(on: boardState, for: Player.white))
    }
    
    func testFirstFiveConsecutiveInAnyRow_isAWin()  {

        for row in 0..<board.height {
            board = Game.boardFactory.makeBoard()
            boardState = board as! BoardState
            for column in 0..<5 {
                _ = board.place(at: Intersection(row, column), by: Player.black)
            }
            XCTAssertTrue(rules.isWin(on: boardState, for: Player.black))
        }
    }
    
    func testFiveNonConsecutiveStonesInRow_isNotAWin() {
        board.place(at: Intersection(1,0), by: Player.white)
        board.place(at: Intersection(3,0), by: Player.white)
        board.place(at: Intersection(5,0), by: Player.white)
        board.place(at: Intersection(7,0), by: Player.white)
        board.place(at: Intersection(9,0), by: Player.white)
        
        XCTAssertFalse(rules.isWin(on: boardState, for: Player.white))
    }
    
    func testFiveConsecutiveStonesInColumn_isAWin() {
        for row in 0..<board.height {
            board.place(at: Intersection(row, 0), by: Player.white)
        }
        XCTAssertTrue(rules.isWin(on: boardState, for: Player.white))
    }
}
