// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";


contract testToken is Token {

    // Token  public token;
    // User user;
    address user = msg.sender;
    constructor (){
        // token = new Token();
        // user  = new User();

        // token.transfer();
        // token.balances(user) = 10000;
        balances[user] = 10_000;
    }

    function echidna_test_Balances() public view returns(bool) {
        // assert(balances(user) <= 10000);
        return balances[user] <= 10000;
    }
}