// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";

contract DeployGasliteDrop is Script {
    function run() public returns (GasliteDrop gasliteDropContract) {
        gasliteDropContract = deployGasliteDrop();
    }

    function deployGasliteDrop() public returns (GasliteDrop) {
        return new GasliteDrop();
    }
}
