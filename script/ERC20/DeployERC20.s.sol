// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";
import {ERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {TestToken} from "../../src/ERC20/TestERC20.sol";

contract DeployERC20 is Script {
    function run() public returns (ERC20) {
        return deployToken();
    }

    function deployToken() public returns (ERC20) {
        DeploymentHelper deploymentHelper = new DeploymentHelper();
        (string memory tokenName, string memory tokenSymbol, address distributor, uint256 tokenSupply) =
            deploymentHelper.getTokenDeploymentData();

        TestToken token = new TestToken(tokenName, tokenSymbol, distributor, tokenSupply);
        return ERC20(token);
    }
}
