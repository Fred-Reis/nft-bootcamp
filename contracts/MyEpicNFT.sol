//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("It's my NFT contract baby!");
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokensIds.current();
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/J3L2");
        console.log(
            "A new epic NFT with ID %s has been minted to %s",
            newItemId,
            msg.sender
        );
        _tokensIds.increment();
    }
}
