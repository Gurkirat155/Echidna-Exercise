// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "./mintable.sol";

contract testToken is MintableToken {

    // Create a scenario where echidna (tx.origin) becomes the owner of the contract at construction, and totalMintable is set to 10,000. Remember that Echidna needs a constructor without arguments.
    // Add a property to check if echidna can mint more than 10,000 tokens.
    // Once Echidna finds the bug, fix the issue, and re-try your property with Echidna.

    // @audit i think their are two invariant here
    // 1. will be that the balances of the msg.sender should never greater than totalMinted
    // 2. will be that the totalMintable > totalMinted 
    // 3. See if the user can mint more that what is the limit 

    address user = msg.sender;

    constructor () MintableToken(10000) {
        owner = user;
    }

    function echidna_user_can_mint_more_than_totalMintable() public view returns(bool) {
        // return totalMinted < 10000;
        return balances[msg.sender] <= 10_000;
    }
    // Below test could have been also performed bu the thing is than you should change the code in the mintable.sol
    // at line 29 --  balances[msg.sender] += value; to balances[owner] += value;
    // function echidna_bal_ofuser_not_greater_than_totalMinted() public view returns(bool){
    //     return int256(balances[owner]) == totalMinted;
    //     // return totalMinted <= totalMintable;
    // }
}