// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {DeployGasliteDrop} from "../../script/ERC721/DeployGasliteDrop.s.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";

contract ETHGasliteDropTest is Test, AirdropUtils {
  GasliteDrop private gasliteDropContract;

  uint256 private TOTAL_AIRDROP_AMOUNT = 1000;
  uint256 private AIRDROP_AMOUNT = 1 ether;
  address[] private airdropAddresses;
  uint256[] private airdropAmounts;
  uint256 private ethToAirdrop;

  function setUp() public {
    gasliteDropContract = new GasliteDrop();

    airdropAddresses = generateAirdropAddresses(TOTAL_AIRDROP_AMOUNT);
    airdropAmounts = generateAmounts(AIRDROP_AMOUNT, TOTAL_AIRDROP_AMOUNT);
    ethToAirdrop = sumArray(airdropAmounts);

    vm.deal(ANVIL_DEFAULT_ADDRESS, ethToAirdrop);
  }

  function test_ETH_sendsETHToRandomAddresses() public {
    vm.prank(ANVIL_DEFAULT_ADDRESS);
    gasliteDropContract.airdropETH{value: ethToAirdrop}(airdropAddresses, airdropAmounts);
  }
}