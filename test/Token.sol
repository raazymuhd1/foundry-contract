// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {TokenA} from "../src/TokenA.sol";

contract TokenTest is Test {
    uint256 initialSupply = 1000_000 * 1e8;
    TokenA token;
    bytes32 private CLAIMER_ROLE = keccak256("CLAIMER_ROLE");

    function setUp() public {
        token = new TokenA();
    }

    function testFail_renounce() public {
        token.renounceOwner_(address(0), "renounced");
        assertEq(token.getOwner(), address(0));

        // vm.expectEmit();
    }

    function test_transfer() public {
        uint256 balance = token.balanceOf(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        token.transfer(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 1000);
    }
}
