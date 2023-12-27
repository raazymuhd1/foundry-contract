// SPDX-Licenses-Identifier: MIT;
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFund} from "../../script/FundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address public USER = makeAddr("USER");
    uint256 constant FUND = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    /* 3 TESTING PATTERN;
     * arrange
     * act
     * assert 
     * 
     */

    modifier Funded() {
        vm.prank(USER); // set the caller to USER addr;
        fundMe.fund{value: FUND}();
        _;
    }

    function setUp() external {
        DeployFund deployFund = new DeployFund();
        fundMe = deployFund.run();
        vm.deal(USER, STARTING_BALANCE); // give a 10 ether to new create wallet;
    }

    function test_fund() public {
        console.log("%s", fundMe.MINIMUM_USD());
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwner() public {
        console.log(fundMe.i_owner(), msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testVersion() public {
        console.log(fundMe.getVersion());
        assertEq(fundMe.getVersion(), 4);
    }

    function test_sendFund() public Funded {
        uint256 amountFunded = fundMe.getAccountToAmtFunded(USER);
        assertEq(amountFunded, FUND);
    }

    function test_addFunder() public Funded {
        address funder = fundMe.getFunder(0); // get funder on idx 0
        assertEq(funder, USER);
    }

    // always remember each this test function will reset anything
    function test_onlyOwnerWd() public Funded {
        // ARRANGE
        uint256 startBalanceOwner = fundMe.i_owner().balance;
        uint256 startFundBalance = address(fundMe).balance;
        console.log("start balance", startFundBalance, startBalanceOwner);

        // ACT
        vm.prank(fundMe.i_owner()); // USER addr try to wd and it will fail
        fundMe.withdraw();

        uint256 afterOwnerBalance = fundMe.i_owner().balance;
        uint256 afterFundBalance = address(fundMe).balance;

        // ASSERT
        console.log("after balance", afterOwnerBalance, afterFundBalance);
        assertEq(startBalanceOwner + startFundBalance, afterOwnerBalance);
    }
}
