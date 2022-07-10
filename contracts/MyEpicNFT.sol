//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    string svgPartOne =
        "<svg  xmlns='http://www.w3.org/2000/svg'  preserveAspectRatio='xMinYMin meet'  viewBox='0 0 350 350'>  <defs>    <linearGradient id='Gradient1'>      <stop class='stop1' offset='0%'/>      <stop class='stop2' offset='50%'/>      <stop class='stop3' offset='100%'/>    </linearGradient>  </defs>  <style>    .base {      fill: blue;      font-family: serif;      font-size: 20px;      color: #FFF;    }    .stop1 { stop-color: ";

    string svgPartTwo =
        "; }    .stop2 { stop-color: white; stop-opacity: 0; }    .stop3 { stop-color: yellow; }      </style>  <rect width='100%' height='100%' fill='url(#Gradient1)' />  <text    x='50%'    y='50%'    class='base'    dominant-baseline='middle'    text-anchor='middle'  >";

    string[] colors = [
        "red",
        "#08C2A8",
        "black",
        "yellow",
        "blue",
        "green",
        "#FFF",
        "purple",
        "orange",
        "brown",
        "pink",
        "grey",
        "cyan"
    ];

    string[] firstWords = [
        "Ferrari",
        "Fusca",
        "Cherokee",
        "Chevette",
        "Mustang",
        "Camaro",
        "Corvette",
        "Challenger",
        "Brasilia",
        "Compass",
        "Parati",
        "Punto",
        "Gol",
        "Palio",
        "Uno",
        "Maverick"
    ];
    string[] secondWords = [
        "Spider-man",
        "Super-man",
        "Greenlight",
        "Thor",
        "Wolverine",
        "Cyclops",
        "Wonder-woman",
        "He-man",
        "Tundercats",
        "Gambit",
        "Jyraya",
        "Power-Rangers",
        "Ryu",
        "Ken",
        "Sub-Zero",
        "Mario-Bros"
    ];
    string[] thirdWords = [
        "Attack",
        "Defense",
        "Speed",
        "Strength",
        "Intelligence",
        "Luck",
        "Health",
        "Energy",
        "Power",
        "Armor",
        "Magic",
        "Dark",
        "Light",
        "Time",
        "Space",
        "Soul"
    ];

    event NewEpicNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("It's my NFT contract baby!");
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(
                abi.encodePacked("PRIMEIRA_PALAVRA", Strings.toString(tokenId))
            )
        );
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(
                abi.encodePacked("SEGUNDA_PALAVRA", Strings.toString(tokenId))
            )
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(
                abi.encodePacked("TERCEIRA_PALAVRA", Strings.toString(tokenId))
            )
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function pickRandomColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("COLOR", Strings.toString(tokenId)))
        );
        rand = rand % colors.length;
        return colors[rand];
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokensIds.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(
            abi.encodePacked(first, " - ", second, " - ", third)
        );
        string memory randomColor = pickRandomColor(newItemId);

        string memory finalSvg = string(
            abi.encodePacked(
                svgPartOne,
                randomColor,
                svgPartTwo,
                combinedWord,
                "</text></svg>"
            )
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", "description": "Uma colecao aclamada e famosa de NFTs maravilhosos.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);

        _tokensIds.increment();

        console.log(
            "A new epic NFT with ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}
