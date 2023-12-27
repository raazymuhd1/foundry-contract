// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFund is Script {
    function run() public returns (FundMe) {
        // anything bfore broadcast is not gonna cost a gas, only after broadcast will cost a gas
        HelperConfig helper = new HelperConfig();
        address priceFeed = helper.activeNetwork();
        // uint256 deployerKey = vm.envUnit("PRIVATE_KEY");
        vm.startBroadcast();
        FundMe fundMe = new FundMe(priceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
