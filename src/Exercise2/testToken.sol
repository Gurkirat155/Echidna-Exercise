// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

// pause i called at deployment
// Remove Ownership


contract testToken is Token {

    // address constant USER_1 = 0x9876543210987654321098765432109876543210;
    constructor () {
        paused();
        owner = address(0);

    }

    // function echidna_test_cannot_be_unpaused() public view returns(bool) {
    //     return balances[USER_1] == 0;
    // }

    function echidna_unpause() public view returns(bool){
        return (paused() == true);
    }
}