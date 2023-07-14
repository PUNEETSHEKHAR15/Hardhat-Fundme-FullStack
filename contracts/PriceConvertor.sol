// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 1e18);
    }

    /*
    function getversion() public view returns (uint256) {
        AggregatorV3Interface version = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return version.version();
    }
*/
    function GetConversionRate(uint EthAmount) public view returns (uint256) {
        uint Ethprice = getPrice();
        uint AmountInUSd = (EthAmount * Ethprice) / 1e18;
        return AmountInUSd;
    }
}
