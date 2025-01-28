// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FlashLoanReceiver.sol";
import "./NaiveReceiverLenderPool.sol";

contract EchidnaNaiveReciever {

    NaiveReceiverLenderPool  naiveReceiverLenderPool;
    FlashLoanReceiver  flashLoanReceiver ;

    uint256 public poolBalance = 1000 ether;
    uint256 public userBalance = 10 ether;

    // the lender pool should have 1000 eth of bal 
    // The flashloan reciever also has a bal
    constructor() payable {
        naiveReceiverLenderPool = new NaiveReceiverLenderPool();
        payable(address(naiveReceiverLenderPool)).transfer(poolBalance);
        flashLoanReceiver = new FlashLoanReceiver(payable(address(naiveReceiverLenderPool)));

        // address(this).balance = 2000 ether;
        // naiveReceiverLenderPool.receive(poolBalance);
        // (bool success,) = payable(address(naiveReceiverLenderPool)).call{value: poolBalance}("");
        // require(success, "Failed to fund the pool");

        // (success, ) = payable(address(flashLoanReceiver)).call{value: userBalance}("");
        // require(success, "Failed to fund the flash loan receiver");

        
        payable(address(flashLoanReceiver)).transfer(userBalance);

    }

    // function echidna_test_flashloan_fail() public returns(bool) {
    //     naiveReceiverLenderPool.flashLoan(address(flashLoanReceiver),10 ether);
    //     return true;
    // }

    function echidna_test_flashloan_fail_dynamic() public view returns(bool) {
        // naiveReceiverLenderPool.flashLoan(address(flashLoanReceiver),amount);
        
        return address(flashLoanReceiver).balance >= 10 ether;
    }

}

