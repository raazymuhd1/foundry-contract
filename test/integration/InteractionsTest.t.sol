// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {FundedMe, WithdrawMe} from "../../script/Interactions.s.sol";
import {DeployFund} from "../../script/FundMe.s.sol";

contract InterationTest is Test {
    FundMe fundMe;
    address public USER = makeAddr("USER");
    uint256 constant FUND = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFund deployFund = new DeployFund();
        fundMe = deployFund.run();
        vm.deal(USER, STARTING_BALANCE); // create wallet and give a starting balance 10 ether;
    }

    // this is integration test
    function testUserCanFundInteractions() public {
        FundedMe funded = new FundedMe();
        funded.fundingMe(address(fundMe));

        WithdrawMe wdMe = new WithdrawMe();
        wdMe.withdrawingMe(address(fundMe));

        uint256 owner = fundMe.i_owner().balance;
        assertNotEq(owner, address(fundMe).balance);
    }
}
