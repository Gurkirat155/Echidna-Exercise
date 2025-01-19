// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract MintableToken is Token {
    int256 public totalMinted;
    int256 public totalMintable;

    constructor(int256 totalMintable_) {
        totalMintable = totalMintable_;
    }

    //@audit To prevent this type of bug, you must ensure that value is always within the valid range of int256 before performing the cast. Add an explicit check for value:

    // function mint(uint256 value) public onlyOwner {
    //     require(value <= uint256(type(int256).max), "Value exceeds int256 range");
    //     require(int256(value) + totalMinted <= totalMintable, "Mint exceeds total mintable tokens");

    //     totalMinted += int256(value);
    //     balances[msg.sender] += value;
    // }

    function mint(uint256 value) public onlyOwner {
        require(int256(value) + totalMinted < totalMintable);
        // require(value <=  uint256(type(int256).max) , "Value more than the int256 ");
        totalMinted += int256(value);

        balances[msg.sender] += value;
    }

}
    // @audit i think their are two invariant here
    // 1. will be that the balances of the mag.sender should never greater than totalMinted
    // 2. will be that the totalMintable > totalMinted 
    // 3. See if the user can mint more that what is the limit 