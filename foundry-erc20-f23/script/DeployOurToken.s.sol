// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import { Script } from "forge-std/Script.sol";
import { MyToken } from  "../src/ManualToken.sol";
import { console } from "forge-std/console.sol";

contract DeployOurToken is Script {
    function run() external {
        uint256 initialSupply = 1_000_000;

        vm.startBroadcast();
        MyToken token = new MyToken(initialSupply);
        console.log("Deployed token address:", address(token));

        vm.stopBroadcast();
    }
}