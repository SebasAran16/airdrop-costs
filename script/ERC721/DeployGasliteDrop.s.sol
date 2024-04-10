// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {DeployNFT} from "./DeployNFT.s.sol";

contract DeployGasliteDrop is Script {
    function run() public returns (GasliteDrop gasliteDropContract, IERC721 nft) {
        gasliteDropContract = deployGasliteDrop();
        nft = deployNFT();
    }

    function deployGasliteDrop() public returns (GasliteDrop) {
        return new GasliteDrop();
    }

    function deployNFT() public returns (IERC721) {
        DeployNFT nftDeployer = new DeployNFT();
        return nftDeployer.run();
    }
}
