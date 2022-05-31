# Lottery

This is a decentralized smart contract programmed using Solidity.

1. The lottery begins by accepting ETH transactions from users can send ETH (1.0 ETH required) to the smart contract. Users can send more transactions to increase their chances of winning.

2. There is a manager who is allowed to deploy the smart contract, get the balance, and randomly select a winner (minimum 3 players).

3. Once the manager picked a winner, the contract will transfer the entire balance of the contract to the winner's address.

4. The manager can then reset the lottery.