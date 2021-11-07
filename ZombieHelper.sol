pragma solidity >=0.5.0 <0.6.0;
import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    } //end modifier aboveLevel()

    function changeName(uint zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(zombieToOwner[_zombieId] == msg.sender);
        zombies[_zombieId].name = _newName;
    } //end function changeName()

    function changeDna(uint zombieId, string calldata _newName) external aboveLevel(20, _zombieId) {
        require(zombieToOwner[zombieId] == msg.sender);
        zombies[_zombieId].dna = _newDna;
    } //end function changeDna()
} //end contract ZombieHelper{}