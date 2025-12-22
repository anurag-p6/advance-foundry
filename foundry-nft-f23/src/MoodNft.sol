//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {Base64} from '@openzeppelin/contracts/utils/Base64.sol';

contract MoodNft is ERC721 {
  //error
  error error_CantFlipMoodIfNotOwner();

  uint256 private s_tokenCounter;
  string private s_sadMoodImageUri;
  string private s_happyMoodImageUri;

  enum Mood {   
    SAD,
    HAPPY
  }
  
  mapping(uint256 => Mood) private s_tokenIdToMood;


  constructor(
    string memory sadMoodImageUri,
    string memory happyMoodImageUri
  ) ERC721("Mood NFT", "MN") {
    s_tokenCounter = 0;
    s_sadMoodImageUri = sadMoodImageUri;
    s_happyMoodImageUri = happyMoodImageUri; 
   }


  function mintNft() public {
    _safeMint(msg.sender, s_tokenCounter);
    s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
    s_tokenCounter++;
  }

  function flipMood(uint256 tokenId) public {
    //only owner can flip the mood
  
      if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
     revert error_CantFlipMoodIfNotOwner();
    }

    if(s_tokenIdToMood[tokenId] == Mood.SAD) {
      s_tokenIdToMood[tokenId] = Mood.HAPPY;
    } else {
      s_tokenIdToMood[tokenId] = Mood.SAD;
    }

  }

  function _baseURI() internal pure override returns (string memory) {
      return "data:application/json;base64,";
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    string memory imageURI;

    if(s_tokenIdToMood[tokenId] == Mood.SAD) {
    imageURI = s_sadMoodImageUri;
    } else {
    imageURI = s_happyMoodImageUri;
    }
     
     return 
        string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '","description":"A NFT about Anurag", "attributes":[{"trait_type":"cuteness","value":100}],"image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        )
      ;
    }
}