// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";

contract Deploy is Script {
    uint256 public constant INITIAL_SUPPLY = 10000000 ether;

    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ot = new OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ot;
    }
}
