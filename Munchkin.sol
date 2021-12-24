pragma solidity 0.4.25;

import "./ZB/ZBGameMode.sol";

// 1. Change the name of this contract
contract ExampleGame is ZBGameMode  {

    function beforeMatchStart(bytes serializedGameState) external {

        GameState memory gameState;
        gameState.init(serializedGameState);

        ZBSerializer.SerializedGameStateChanges memory changes;
        changes.init();

        // Custom game logic will go here

        changes.emit();

    } //end function beforeMatchStart()

} //end contract Munchkin{}