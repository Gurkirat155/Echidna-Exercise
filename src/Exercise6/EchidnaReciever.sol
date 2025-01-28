// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./ReceiverUnstoppable.sol";
// import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./DamnValuableToken.sol";
import "./UnstoppableLender.sol";


contract EchidnaReciever {

    address setOwner = msg.sender;
    IERC20 public damnValuableToken;
    ReceiverUnstoppable public receiverUnstoppable;
    UnstoppableLender public unstoppableLender;
    uint256 public INITIAL_BAL_In_POOL = 100000;
    uint256 public BAL_OF_USER = 100;
    uint256 balanceBefore ;

    constructor(){
        damnValuableToken = new DamnValuableToken();
        unstoppableLender = new UnstoppableLender(address(damnValuableToken));
        receiverUnstoppable = new ReceiverUnstoppable(address(unstoppableLender));

        damnValuableToken.approve(address(unstoppableLender), INITIAL_BAL_In_POOL);
        unstoppableLender.depositTokens(INITIAL_BAL_In_POOL);

        damnValuableToken.transfer(setOwner,BAL_OF_USER);
        balanceBefore = damnValuableToken.balanceOf(address(unstoppableLender));
    }

    function receiveTokens(address tokenAddress, uint256 amount) external {
        require(msg.sender == address(unstoppableLender), "Sender must be pool");
        // Return all tokens to the pool
        require(
            IERC20(tokenAddress).transfer(msg.sender, amount),
            "Transfer of tokens failed"
        );
    }

    function echidna_poolBal_is_always_equal_to_intialBal() public  returns(bool)  {
        // assert(unstoppableLender.poolBalance() == balanceBefore);
        // require(msg.sender == )
        unstoppableLender.flashLoan(10);
        // receiverUnstoppable.executeFlashLoan(10);
        return true;
    }




}
