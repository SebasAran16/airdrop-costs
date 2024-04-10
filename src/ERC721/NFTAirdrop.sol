// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract NFTAirdrop is ERC721 {
    using Strings for uint256;

    string private constant BASE_EXTENSION = ".json";
    string private s_baseUri;

    constructor(string memory baseUri, address[] memory _airdropAddresses) ERC721("EMT - Incentivize NFT", "EMTI") {
        s_baseUri = baseUri;

        for (uint256 i; i < _airdropAddresses.length; i++) {
            _mint(_airdropAddresses[i], i);
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return s_baseUri;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        return string.concat(_baseURI(), tokenId.toString(), BASE_EXTENSION);
    }
}
