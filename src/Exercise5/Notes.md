I was getting the below error in the image which was solved by multiple debugging steps, error I am getting because echidna give some errors while using third part libraries or external libraires 
![alt text](1.png)

1. Adding the below in config file of the echidna test file 
`cryticArgs: ["--foundry-compile-all"]`

2. Which was solved by getting out of the Exercise5 directory and going to main directory an d running below command
`echidna . src/Exercise5 --contract EchidnaTest --config src/Exercise5/ext.config.yaml`

3. This is the main thing that solved the error ----- Intalling  new solidity verison which was used in all the contracts `solc-select use 0.8.20` in the terminal 



## Q1: Why does the transfer function of the ERC20 token work in the Echidna test, but the receiveTokens function doesn’t, unless explicitly implemented in EchidnaTest?
A:
The transfer function works because the UnstoppableLender contract has a direct instance of the ERC20 token (damnValuableToken) declared as:

IERC20 public immutable damnValuableToken;
This provides access to the full implementation of the ERC20 token contract, including its logic and require statements.

In contrast, the receiveTokens function is called via an interface (IReceiver) in the line:

IReceiver(msg.sender).receiveTokens(address(damnValuableToken), borrowAmount);
Interfaces only declare function signatures without implementing them. The protocol expects msg.sender (the caller of flashLoan) to implement the receiveTokens function. If msg.sender (in this case, EchidnaTest) doesn’t implement it, the call fails.


## Q2: Why do I need to implement the receiveTokens function in EchidnaTest?
A:
When you call unstoppableLender.flashLoan directly from EchidnaTest, the msg.sender inside the UnstoppableLender contract becomes EchidnaTest. The protocol then attempts to invoke:

IReceiver(msg.sender).receiveTokens(...)
If EchidnaTest doesn’t implement the receiveTokens function, the call fails. By implementing receiveTokens in EchidnaTest, you allow the protocol to execute this function and test the flash loan logic.


## Q3: How does implementing receiveTokens in EchidnaTest solve the issue?
A:
By implementing receiveTokens in EchidnaTest, you fulfill the protocol's requirement that msg.sender (the caller of flashLoan) implements the IReceiver interface. Since EchidnaTest is the msg.sender during direct calls to flashLoan, this allows the protocol to execute the flash loan logic successfully.


## Q4: How can I test the ReceiverUnstoppable contract in Echidna instead of implementing receiveTokens in EchidnaTest?
A:
To test with ReceiverUnstoppable, you need to ensure that it becomes the msg.sender during the flashLoan call. This can be done by calling:

receiverUnstoppable.executeFlashLoan(amount);
For example, add a test in EchidnaTest like this:

`function echidna_test_with_receiver_unstoppable() public returns (bool) {`
    `receiverUnstoppable.executeFlashLoan(10); // ReceiverUnstoppable is now the msg.sender`
    `return true;`
`}`
with this you could comment out the recieveTokens in EchidnaTest and run without recieveTokens 
This ensures that the protocol calls `ReceiverUnstoppable.receiveTokens` as expected.

