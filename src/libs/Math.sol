// SPDX-Licenses-Identifier: MIT;
pragma solidity ^0.8.23;

library Math {
    function Add(uint256 amount, uint256 amountToAdd) internal pure returns (uint256) {
        uint256 total = amount + amountToAdd;
        return total;
    }

    function Sub(uint256 amount, uint256 amountToSub) internal pure returns (uint256) {
        uint256 subbed = amount - amountToSub;
        return subbed;
    }
}
