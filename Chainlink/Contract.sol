pragma solidity ^0.6.7;

import "./VRFConsumerBase.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface public priceFeed;
    constructor() public {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    } //end constructor()

    function getLatestPrice() public view returns(int) {
        (,int price,,,) = priceFeed.latestRoundData();
        return price;
    } //end function getLatestPrice()

    function getDecimals() public view returns(uint8) {
        uint8 decimals = priceFeed.decimals();
        return decimals;
    } //end function getDecimals()

} //end contract PriceConsumerV3{}