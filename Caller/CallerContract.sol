pragma solidity 0.5.0;
import "./EthPriceOracleInterface.sol";
import "./Ownable.sol";

contract CallerContract is Ownable {
    address private oracleAddress;
    mapping(uint256=>bool) myRequests;
    EthPriceOracleInterface private oracleInstance;
    event newOracleAddressEvent(address oracleAddress);
    event ReceivedNewRequestIdEvent(uint256 id);

    function setOracleInstanceAddress(address _oracleInstanceAddress) public onlyOwner {
        oracleAddress = _oracleInstanceAddress;
        oracleInstance = EthPriceOracleInterface(oracleAddress);
        emit newOracleAddressEvent(oracleAddress);
    } //end function setOracleInstanceAddress()

    function updateEthPrice() public {
        uint256 id = oracleInstance.getLatestEthPrice();
        myRequests[id] = true;
        emit ReceivedNewRequestIdEvent(id);
    } //end function updateEthPrice()
} //end contract CallerContract{}