// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AirdropUtils} from "../../test/utils/AidropUtils.t.sol";

contract InteractionsHelper is AirdropUtils {
  string public constant AIRDROP_FOLDER_PATH = "./utils/airdrop/";
  string public constant TXT_EXTENSION = ".txt";
  string public constant JSON_EXTENSION = ".json";
  string public constant ENV_AIRDROP_KEY = "AIRDROP_CONTRACT";
  string public constant ETH_AIRDROP_FOLDER = "eth/";
  string public constant AIRDROP_DATA_FILE = "AirdropData";
  uint256 public constant LOCAL_CHAIN_ID = 31337;
  uint256 public constant ANVIL_DEFAULT_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

  function getNetworkOwnerPrivateKey() public view returns (uint256 ownerPrivateKey) {
    if (block.chainid == LOCAL_CHAIN_ID) {
      ownerPrivateKey = ANVIL_DEFAULT_PRIVATE_KEY;
    } else {
      ownerPrivateKey = vm.envUint(string.concat("ACTOR_PRIVATE_KEY_", vm.toString(block.chainid)));
    }
  }

  function getChainAirdropContract() public view returns (address airdropContract)  {
    string memory blockIdString = vm.toString(block.chainid);
    string memory airdropContractENVKey = string.concat(ENV_AIRDROP_KEY, "_", blockIdString);

    airdropContract = vm.envAddress(airdropContractENVKey);
  }

  function getETHAirdropData() public view returns (uint256[] memory airdropAmounts, address[] memory recipientAddresses, uint256 totalAirdropAmounts) {
    string memory filePath = string.concat(AIRDROP_FOLDER_PATH, ETH_AIRDROP_FOLDER, AIRDROP_DATA_FILE, JSON_EXTENSION);
    string memory jsonDataStringified = vm.readFile(filePath);

    recipientAddresses = vm.parseJsonAddressArray(jsonDataStringified, ".recipients");
    airdropAmounts = generateAmounts(vm.parseJsonUint(jsonDataStringified, ".amount"), recipientAddresses.length);
    totalAirdropAmounts = sumArray(airdropAmounts);
  }
}
