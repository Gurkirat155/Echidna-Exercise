// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SideEntranceLenderPool.sol";


contract EchidnaSideEntrance   {

    SideEntranceLenderPool public pool;

    constructor () {
        pool = new SideEntranceLenderPool() ;

    }


}