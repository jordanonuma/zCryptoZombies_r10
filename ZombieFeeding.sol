pragma solidity >=0.5.0 <0.6.0;
import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        Zombie storage myZombie = zombies[_zombieId]; //array 'myZombie' of structs type Zombie[]
    } //end function feedAndMultiply()
} //end contract ZombieFeeding{}