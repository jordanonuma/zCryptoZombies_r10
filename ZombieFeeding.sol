pragma solidity >=0.5.0 <0.6.0;
import "./ZombieFactory.sol";

contract KittyInterface {
    
} //end KittyInterface{}
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId]; //array 'myZombie' of structs type Zombie[]

        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    } //end function feedAndMultiply()
} //end contract ZombieFeeding{}