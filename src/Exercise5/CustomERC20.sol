// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;


import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CustomERC20 is ERC20   {

    constructor() ERC20("damn","dd") {
        _mint(msg.sender,type(uint256).max);
    }
}