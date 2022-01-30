pragma solidity 0.5.0;
import "./EthPriceOracleInterface.sol";

contract CallerContract {
    address private oracleAddress;
    EthPriceOracleInterface private oracleInstance;

    function setOracleInstanceAddress(address _oracleInstanceAddress) public {
        oracleAddress = _oracleInstanceAddress;
        oracleInstance = EthPriceOracleInterface(oracleAddress);
    } //end function setOracleInstanceAddress()
} //end contract CallerContract{}