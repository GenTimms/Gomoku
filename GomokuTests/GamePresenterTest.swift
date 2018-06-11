import XCTest
@testable import Gomoku

class GamePresenterTest: XCTestCase {
    var presenter: GamePresenter!
    
    override func setUp() {
        presenter = GamePresenter()
        super.setUp()
    }
    
    func testFormatOfPlayerStatus() {
        XCTAssertEqual("White's Turn", presenter.getPlayerStatus(for: Player.white))
        XCTAssertEqual("Black's Turn", presenter.getPlayerStatus(for: Player.black))
    }
    
    func testFormatOfPlayerWinStatus() {
        XCTAssertEqual("White Wins!", presenter.getWinStatus(for: Player.white))
        
    }
}
