pragma solidity ^0.6.7;

contract PriceConsumerV3 {

    AggregatorV3Interface public priceFeed;
    constructor() public {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    } //end constructor()

    function getLatestPrice() public view returns(uint) {
      
    } //end function getLatestPrice()

} //end contract PriceConsumerV3{}