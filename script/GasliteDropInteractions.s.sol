// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {InteractionsHelper} from "./utils/InteractionsHelper.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";

contract AirdropETHGasliteAirdrop is Script {
    function run() external {
        airdropETHGasliteAirdrop();
    }

    function airdropETHGasliteAirdrop() public {
        InteractionsHelper helper = new InteractionsHelper();
        GasliteDrop airdropContract = GasliteDrop(helper.getChainAirdropContract());
        (uint256[] memory airdropAmounts, address[] memory recipients, uint256 totalAirdropAmount) =
            helper.getETHAirdropData();

        vm.startBroadcast(helper.getNetworkOwnerPrivateKey());
        airdropContract.airdropETH{value: totalAirdropAmount}(recipients, airdropAmounts);
        vm.stopBroadcast();
        console.log("Airdropped ETH to selected users, each received: %s", airdropAmounts[0]);
    }
}
