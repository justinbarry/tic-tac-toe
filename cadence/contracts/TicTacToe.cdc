

pub contract TicTacToe {
    pub let GameCollectionStoragePath: StoragePath;
    pub let GameOpponentPublicPath: PublicPath;

    init() {
        self.GameCollectionStoragePath = /storage/TicTacToeGameCollection;
        self.GameOpponentPublicPath = /public/OpponentReceiver;
    }
    
    pub fun getNum(): UInt64 {
        return 64;
    }

    pub resource interface GameOpponent {
        pub fun createGame(): UInt64
        pub fun makeMove(square: UInt64)
        pub fun getGameCount():UInt64;
    }

    pub resource Game {
        pub var spaces:[Int; 9];

        init() {
            self.spaces = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
    }

    pub fun createGame():UInt64  {
        return 0;
    }

    pub fun createGameCollection():@GameCollection {
        return <- create GameCollection();
    }

    pub resource GameCollection: GameOpponent {
        access(contract) var games: @[Game];
        access(contract) var gameCount: UInt64;

        init() {
            self.games <- [];
            self.gameCount = 10;
        }
        destroy() {
            destroy self.games;
        }

        pub fun createGame():UInt64 {
            self.gameCount = self.gameCount + 1;
            return self.gameCount ;
        }

        pub fun makeMove(square: UInt64) {}

        pub fun getGameCount():UInt64 {
            return self.gameCount + 1;
        }
    }
}
