pragma solidity 0.4.25;

import "./ZB/ZBGameMode.sol";

contract Munchkin is ZBGameMode  {

    function beforeMatchStart(bytes serializedGameState) external {

        GameState memory gameState;
        gameState.init(serializedGameState);

        ZBSerializer.SerializedGameStateChanges memory changes;
        changes.init();

        for (uint i = 0; i < gameState.playerStates.length; i++) {
            CardInstance[] memory newCards = new CardInstance[](gameState.playerStates[i].cardsInDeck.length);
            uint cardCount = 0;

            for (uint j = 0; j < gameState.playerStates[i].cardsInDeck.length; j++) {
                if (isLegalCard(gameState.playerStates[i].cardsInDeck[j])) {
                    newCards[cardCount] = gameState.playerStates[i].cardsInDeck[j];
                    cardCount++;
                } //end if()
            } //end for()

            changes.changePlayerCardsInDeck(Player(i), newCards, cardCount);
        } //end for()

        changes.emit();

    } //end function beforeMatchStart()

    function isLegal(CardInstance[] card) returns(bool) {

    } //end function isLegal()

} //end contract Munchkin{}