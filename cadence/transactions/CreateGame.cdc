import TicTacToe from "../contracts/TicTacToe.cdc";

transaction(account: Address) {
    prepare(acct: AuthAccount) {
        let account = getAccount(account);      
        let opponentCapability = account
            .getCapability(TicTacToe.GameOpponentPublicPath)!
            .borrow<&{TicTacToe.GameOpponent}>()
        ?? panic("Could not borrow Opponent Capability."); 

        opponentCapability.createGame();
    }
 }