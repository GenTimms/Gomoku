import UIKit

class ViewController: UIViewController {
   let labelWidth: CGFloat = 100
    lazy var statusLabel: UILabel = {
       return self.makeStatusLabel()
    }()
    lazy var game: Game = { return Game() }()
    lazy var presenter: GamePresenter = { return GamePresenter() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
                
        let gridView = GridView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.width), board: game.getBoard())
        self.view.addSubview(gridView)
        
        gridView.tapHandler = { row, col in
            self.respondToTap(row: row, col: col)
        }
        
        statusLabel.text = presenter.getPlayerStatus(for: game.whoseTurn())
    }
    
    func respondToTap(row: Int, col: Int) {
        let tappedPlayer = game.whoseTurn()
        game.takeTurn(at: Intersection(row, col))
        if  game.getRules().isWin(on: game.getBoard(), for: tappedPlayer) {
            statusLabel.text = presenter.getWinStatus(for: tappedPlayer)
        } else {
            statusLabel.text = presenter.getPlayerStatus(for: game.whoseTurn())
        }
    }
    
    func makeStatusLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: (view.bounds.width - labelWidth) / 2.0, y: 50, width: labelWidth, height: 25))
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.view.addSubview(label)
        return label
    }
}

