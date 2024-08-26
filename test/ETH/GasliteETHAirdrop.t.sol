// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {DeployGasliteDrop} from "../../script/DeployGasliteDrop.s.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";

contract ETHGasliteDropTest is Test, AirdropUtils {
    GasliteDrop private gasliteDropContract;

    uint256 private TOTAL_AIRDROP_AMOUNT = 1000;
    address[] private airdropAddresses;
    uint256[] private airdropAmounts;
    uint256 private ethToAirdrop;

    function setUp() public {
        DeployGasliteDrop gasliteDropDeployer = new DeployGasliteDrop();
        gasliteDropContract = gasliteDropDeployer.run();

        airdropAddresses = generateAirdropAddresses(TOTAL_AIRDROP_AMOUNT);
        airdropAmounts = generateAmounts(ETH_AIRDROP_AMOUNT, TOTAL_AIRDROP_AMOUNT);
        ethToAirdrop = sumArray(airdropAmounts);

        vm.deal(ANVIL_DEFAULT_ADDRESS, ethToAirdrop);
    }

    function test_ETH_sendsETHToRandomAddressesVerifyReceived() public {
        vm.prank(ANVIL_DEFAULT_ADDRESS);
        gasliteDropContract.airdropETH{value: ethToAirdrop}(airdropAddresses, airdropAmounts);

        for (uint256 i; i < airdropAddresses.length; i++) {
            vm.assertEq(ETH_AIRDROP_AMOUNT, airdropAddresses[i].balance);
        }
    }
}
