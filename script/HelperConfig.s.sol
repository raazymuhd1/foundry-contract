// SPDX-Licenses-Identifier: MIT;
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    uint8 public DECIMALS = 8;
    int256 public INITIAL_PRICE = 2000e8;

    NetworkConfig public activeNetwork;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetwork = getSepolia();
        } else {
            activeNetwork = getAnvil();
        }
    }

    struct NetworkConfig {
        address priceFeed;
    }

    function getSepolia() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepolia = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});

        return sepolia;
    }

    /**
     * @dev get price feed address on anvil network
     */
    function getAnvil() public returns (NetworkConfig memory) {
        // check if a priceFeed addres is not 0 address, if it is then return activeNetwork
        if (activeNetwork.priceFeed != address(0)) {
            return activeNetwork;
        }

        vm.startBroadcast();
        MockV3Aggregator priceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvil = NetworkConfig({priceFeed: address(priceFeed)});
        return anvil;
    }
}
