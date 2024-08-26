// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {AirdropUtils} from "../../utils/AidropUtils.t.sol";
import {AirdropETHGasliteAirdrop} from "../../../script/GasliteDropInteractions.s.sol";
import {InteractionsHelper} from "../../../script/utils/InteractionsHelper.sol";

contract ETHGasliteDropTest is Test, AirdropUtils {
    address[] private airdropAddresses;
    uint256[] private airdropAmounts;
    uint256 private ethToAirdrop;

    function setUp() public {
        InteractionsHelper interactionsHelper = new InteractionsHelper();

        (airdropAmounts, airdropAddresses, ethToAirdrop) = interactionsHelper.getETHAirdropData();
    }

    function test_ETH_useAirdropInteractionVerifyAddressesReceivedAmounts() public {
        AirdropETHGasliteAirdrop airdropETHScript = new AirdropETHGasliteAirdrop();

        airdropETHScript.run();

        for (uint256 i; i < airdropAddresses.length; i++) {
            vm.assertEq(ETH_AIRDROP_AMOUNT, airdropAddresses[i].balance);
        }
    }
}
