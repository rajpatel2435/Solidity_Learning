// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// gas price optimization
// constant, immutable
// those varaibles are not changine it means constant you can decalre them as constat in order to save some gas
//  uint256 public constant MINIMUM_USD  = 100000000000;

contract FundMe {
    uint public myValue = 1;

    uint256 public minimumUsd = 5e18;

    address[] public funders;

    address public owner;

    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;
    // allow user to send money

    function fund() public payable {
        // 1e18 is 1 ether ETH=10^18 wei
        require(
            getConversionRate(msg.value) >= minimumUsd,
            "you need to send more than 1 ether"
        );

        funders.push(msg.sender);
    }
    // what is revert
    // revert is a function in solidity that can be used to return a value or throw an error

    // Transactions- value transfer
    // Nonce - used to ensure that a transaction is not replayed
    // Gas Price - used to ensure that a transaction is not too expensive

    //chainlink feature
    // chainlink data feed  docs.chain.link

    // allow user to recuve money

    // what is the diffrence between returns and return in solidity

    // returns is used to declare the type(s) of value(s) that a function will return. It is used in the function signature, before the function body.

    // return is used to declare the value that a function will return. It is used in the function body.

    function getPrice() public view returns (uint256) {
        AggregatrV3Interface priceFeed = AggregatrV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();

        //  typecasting from int to uint
        return uint256(price * 1e10);
    }

    function getConversionRate(
        uint256 ethAmount
    ) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;

        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256) {
        return
            AggregatrV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }

    function withdraw() public {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // transfer
        // send
        // call

        payable(msg.sender).transfer(address(this).balance);

        // get owne
        // owner= msg.sender
        // check if wthdrwal is possible beacsue of sender
        //  require(ownwer, "")

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }();

        require(callSuccess, "wthdrawal failed");
    }
    //  we an assign this modifier to function just next to function name
    //  _ allow function's body to execute
    modifier onlyOwner() {
        require(msg.sender == owner, "you are not the owner");
        // _; execute the funcion after checking conditiion

        // if _ this is above first render fu ction and check condition
    }

    // fallback

    // receive

    //  is msg.data empty?
    //  yes-> recieve function -> reciever () no recievr function go to fallback()
    // ms.data not empty => fallback
}
