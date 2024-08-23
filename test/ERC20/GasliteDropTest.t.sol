// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {ERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {DeployGasliteDrop} from "../../script/ERC721/DeployGasliteDrop.s.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";
import {DeployERC20} from "../../script/ERC20/DeployERC20.s.sol";

contract GasliteDropTest is Test, AirdropUtils {
    GasliteDrop private gasliteDropContract;
    ERC20 private token;

    uint256 private TOTAL_AIRDROP_AMOUNT = 1000;
    uint256 private AIRDROP_AMOUNT = 1 ether;
    address[] private airdropAddresses;
    uint256[] private tokenIds;
    uint256[] private airdropAmounts;
    uint256 private tokenToAirdrop;

    function setUp() public {
        DeployERC20 tokenDeployer = new DeployERC20();
        uint256 totalAmount = 1_000;

        gasliteDropContract = new GasliteDrop();
        token = tokenDeployer.run();

        airdropAddresses = generateAirdropAddresses(totalAmount);
        airdropAmounts = generateAmounts(AIRDROP_AMOUNT, TOTAL_AIRDROP_AMOUNT);
        tokenToAirdrop = sumArray(airdropAmounts);

        vm.prank(ANVIL_DEFAULT_ADDRESS);
        token.approve(address(gasliteDropContract), tokenToAirdrop);
    }

    function test_ERC20_sendsTokenToRandomAddresses() public {
        vm.prank(ANVIL_DEFAULT_ADDRESS);
        gasliteDropContract.airdropERC20(address(token), airdropAddresses, airdropAmounts, tokenToAirdrop);
    }
}
