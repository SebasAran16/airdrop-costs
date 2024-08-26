// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {ERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {DeployGasliteDrop} from "../../script/DeployGasliteDrop.s.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";
import {DeployERC20} from "../../script/ERC20/DeployERC20.s.sol";

contract GasliteDropTest is Test, AirdropUtils {
    GasliteDrop private gasliteDropContract;
    ERC20 private token;

    uint256 private TOTAL_AIRDROP_AMOUNT = 1000;
    address[] private airdropAddresses;
    uint256[] private tokenIds;
    uint256[] private airdropAmounts;
    uint256 private tokenToAirdrop;

    function setUp() public {
        DeployERC20 tokenDeployer = new DeployERC20();
        uint256 totalAmount = 1_000;

        DeployGasliteDrop gasliteDropDeployer = new DeployGasliteDrop();
        gasliteDropContract = gasliteDropDeployer.run();
        token = tokenDeployer.run();

        airdropAddresses = generateAirdropAddresses(totalAmount);
        airdropAmounts = generateAmounts(ERC20_AIRDROP_AMOUNT, TOTAL_AIRDROP_AMOUNT);
        tokenToAirdrop = sumArray(airdropAmounts);

        vm.prank(ANVIL_DEFAULT_ADDRESS);
        token.approve(address(gasliteDropContract), tokenToAirdrop);
    }

    function test_ERC20_sendsTokenToRandomAddressesVerifyReceived() public {
        vm.prank(ANVIL_DEFAULT_ADDRESS);
        gasliteDropContract.airdropERC20(address(token), airdropAddresses, airdropAmounts, tokenToAirdrop);

        for (uint256 i; i < airdropAddresses.length; i++) {
            vm.assertEq(token.balanceOf(airdropAddresses[i]), airdropAmounts[i]);
        }
    }
}
