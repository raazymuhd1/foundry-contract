// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
// script for integration test

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundedMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundingMe(address recentDeployed) public {
        vm.startBroadcast();
        FundMe(payable(recentDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("funded", recentDeployed);
    }

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundingMe(mostRecentDeployed);
    }
}

contract WithdrawMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function withdrawingMe(address recentDeployed) public {
        vm.startBroadcast();
        FundMe(payable(recentDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("funded", recentDeployed);
    }

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawingMe(mostRecentDeployed);
    }
}
