pragma solidity 0.5.0;
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./CallerContractInterface.sol";

contract EthPriceOracle {
    using Roles for Roles.Role;
    Roles.Role private owners;
    Roles.Role private oracles;

    uint private randNonce = 0;
    uint private modulus = 1000;
    uint private numOracles = 0;
    uint private THRESHOLD = 0;

    mapping(uint256=>bool) pendingRequests;
    event GetLatestEthPriceEvent(address callerAddress, uint id);
    event SetLatestEthPriceEvent(uint256 ethPrice, address callerAddress);
    event AddOracleEvent(address oracleAddress);
    event RemoveOracleEvent(address oracleAddress);

    struct Response {
        address oracleAddress;
        address callerAddress;
        uint256 ethPrice;
    } //end struct{}

    constructor (address _owner) public {
        owners.add(_owner);
    } //end constructor{}

    function addOracle(address _oracle) public {
        require(owners.has(msg.sender), "Not an owner!");
        require(!oracles.has(_oracle), "Already an oracle!");
        oracles.add(_oracle);
        numOracles++;
        emit AddOracleEvent(_oracle);
    } //end function addOracle()
    
    function removeOracle(address _oracle) public {
        require(owners.has(msg.sender), "Not an owner!");
        require(oracles.has(_oracle), "Not an oracle!");
        require(numOracles > 1, "Do not remove the last oracle!");
        oracles.remove(_oracle);
        numOracles--;
        emit RemoveOracleEvent(_oracle);
    } //end function removeOracle()

    function getLatestEthPrice() public returns(uint256) {
        randNonce++;
        uint id = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % modulus;
    
        pendingRequests[id] = true;
        emit GetLatestEthPriceEvent(msg.sender, id);
        return id;
    } //end function getLatestEthPrice()

    function setLatestEthPrice(uint256 _ethPrice, address _callerAddress, uint256 _id) public onlyOwner {
        require(pendingRequests[id], "This request is not in my pending list.");

        Response memory resp;
        resp = Response(msg.sender, _callerAddress, _ethPrice);
        requestIdToResponse[_id].push(resp);

        uint numResponses = requestIdToResponse[_id].length;
        if (numResponses == THRESHOLD) {
            uint computedEthPrice = 0;
            for (uint f=0; f < requestIdToResponse[_id].length; f++) {
                computedEthPrice += requestIdToResponse[_id][f].ethPrice;
                
            } //end for()

            computedEthPrice = computedEthPrice / numResponses; //to take the average of responses

            pendingRequests[_id];
            CallerContractInterface callerContractInstance;
            callerContractInstance = CallerContractInterface(_callerAddress);
            callerContractInstance.callback(_ethPrice, _id);
            emit SetLatestEthPriceEvent(_ethPrice, _callerAddress);
        } //end if()

        delete pendingRequests[id];
        CallerContractInterface callerContractInstance;
        callerContractInstance = CallerContractInterface(_callerAddress);
        callerContractInstance.callback(_ethPrice, _id);
        emit SetLatestEthPriceEvent(_ethPrice, _callerAddress);
    } //end function setLatestEthPrice()
} //end contract EthPriceoracle{}