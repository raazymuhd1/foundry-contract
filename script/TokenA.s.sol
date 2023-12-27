// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {TokenA} from "../src/TokenA.sol";

contract TokenADeploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerKey);

        TokenA token = new TokenA();
        vm.stopBroadcast();
    }
}
