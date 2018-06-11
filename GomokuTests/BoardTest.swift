import XCTest
@testable import Gomoku

class BoardTest: XCTestCase {
    var board: Board!
    var boardData: GameData!
    
    override func setUp() {
        super.setUp()
        boardData = GameData()
        board = boardData
    }
    
    func testNewBoardHasNoStones() {
        let stones = boardData.stonesPlaced()
        XCTAssertEqual(0, stones)
    }
    
    func testCanAddStonesInBounds()  {
        let location1 = Intersection(1,1)
        let location2 = Intersection(2,2)
        
        _ = board.place(at: location1, by: Player.white)
        
        XCTAssertEqual(1, boardData.stonesPlaced())
        XCTAssertEqual(Player.white, board.get(at: location1).0)
        
        _ = board.place(at: location2, by: Player.black)
        
        XCTAssertEqual(2, boardData.stonesPlaced())
        XCTAssertEqual(Player.black, board.get(at: location2).0)
    }
    
    func testKnowsAboutEmptyIntersections() {
        let emptyIntersection = Intersection(0,1)
        XCTAssertEqual(Player.empty, board.get(at: emptyIntersection).0)
        _ = board.place(at: emptyIntersection, by: Player.white)
        XCTAssertEqual(Player.white, board.get(at: emptyIntersection).0)
    }
    
    func testCannotAddToOccupiedIntersection() {
        let occupiedIntersection = Intersection(1,1)
        _ = board.place(at: occupiedIntersection, by: .white)
        XCTAssertEqual(board.place(at: occupiedIntersection, by: .white), BoardError.spaceOccupied)
        XCTAssertEqual(board.place(at: occupiedIntersection, by: .black), BoardError.spaceOccupied)
    }
    
    func testCannotPlaceStonesOutsideBounds() throws {
        XCTAssertEqual(board.place(at: Intersection(-1,-1), by: Player.white), BoardError.badLocation)
        XCTAssertEqual(board.place(at: Intersection(board.height + 1, board.width + 1), by: Player.white), BoardError.badLocation)
        XCTAssertEqual(board.place(at: Intersection(0,-1), by: Player.white), BoardError.badLocation)
        XCTAssertEqual(board.place(at: Intersection(board.height, 0), by: Player.white), BoardError.badLocation)
        XCTAssertEqual(board.place(at: Intersection(-1, 0), by: Player.white), BoardError.badLocation)
        XCTAssertEqual(board.place(at: Intersection(0, board.width), by: Player.white), BoardError.badLocation)
        
        XCTAssertEqual(0, boardData.stonesPlaced())
    }
}
