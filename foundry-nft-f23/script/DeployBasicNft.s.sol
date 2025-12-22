//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Pokemon} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    
    function run() external returns (Pokemon) {
      vm.startBroadcast();
      Pokemon pokemon = new Pokemon();
      vm.stopBroadcast();
      
      return pokemon;
    }
}