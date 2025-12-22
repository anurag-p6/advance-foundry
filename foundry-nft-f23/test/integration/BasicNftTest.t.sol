//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Pokemon} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract TestPokemon is Test {
  DeployBasicNft public deployer;
  Pokemon public pokemonNft;
  address public constant USER = address(1);
  string public PUG_URI=
              "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4";


  function setUp() public {
    deployer = new DeployBasicNft();
    pokemonNft = deployer.run();
  }

  function testNameIsCorrect() public view{
    string memory expectedName = 'Pikachu';
    string memory actualName = pokemonNft.name();

    assertEq(keccak256(abi.encodePacked(expectedName)), keccak256(abi.encodePacked(actualName)));
  }

  function testMintNftAndBalance() public{
    vm.prank(USER);
    pokemonNft.mintNft(PUG_URI);

    assert(pokemonNft.balanceOf(USER) == 1);
  }
  
  function testTokenUriIsCorrect() public {
    vm.prank(USER);
    pokemonNft.mintNft(PUG_URI);

    assertEq(
       keccak256(abi.encodePacked(pokemonNft.tokenURI(0))),
       keccak256(abi.encodePacked(PUG_URI))
    );
  }

}
