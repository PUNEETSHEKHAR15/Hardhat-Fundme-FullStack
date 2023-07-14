// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./PriceConvertor.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error NotOwner();

contract FundMe {
    using PriceConvertorSol for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    address[] public funders;
    mapping(address => uint256) public addressToAmount;

    function fundme() public payable {
        require(
            msg.value.GetConversionRate() >= MINIMUM_USD,
            "Amount entered is not enough"
        );
        funders.push(msg.sender);
        addressToAmount[msg.sender] += msg.value;
    }

    modifier onlyowner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    function withdraw() public onlyowner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmount[funder] = 0;
        }
        funders = new address[](0);
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "call failed");
    }

    // to tranfer amount form outside
    fallback() external payable {
        fundme();
    }

    // executes when call data is not empty or receieve is not present or ethers are sent from outside

    receive() external payable {
        fundme();
    }
}
