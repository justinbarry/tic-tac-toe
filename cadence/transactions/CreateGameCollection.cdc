import TicTacToe from "../contracts/TicTacToe.cdc";

transaction() {
    prepare(acct: AuthAccount) {
        acct.save(<- TicTacToe.createGameCollection(), to: TicTacToe.GameCollectionStoragePath)
        acct.link<&TicTacToe.GameCollection{TicTacToe.GameOpponent}>(
            TicTacToe.GameOpponentPublicPath, 
            target: TicTacToe.GameCollectionStoragePath
        )
    }
 }