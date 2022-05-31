pragma solidity >= 0.6.0 < 0.9.0;

contract Lottery {
    // address is payable because the winner 
    // will be selected and balance of lottery
    // paid to the winner
    address payable [] public players;
    address payable public manager;

    modifier onlyManager {
        require(msg.sender == manager, "You are not the manager!");
        _;
    }

    constructor() {
        manager = payable(msg.sender);
        players.push(manager);
    }

    // contract now can receive ether
    receive() external payable {
        require(msg.sender != manager, "Manager is not allowed to participate in the lottery!");
        require(msg.value == 1 ether, "You need to send exactly 1 Ether.");
        players.push(payable(msg.sender));
    }

    // get balance of the contract
    function getBalance() public view onlyManager returns(uint)  {
        return address(this).balance;
    }

    // randomly select a winner using index of players' addresses
    function selectWinner() public {
        require(players.length >= 3, "There are not enough players!");
        manager.transfer(address(this).balance * 10 / 100);
        if (players.length < 10) {
            require(msg.sender == manager, "You are not the manager!");
            return players[uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length))) % players.length].transfer(getBalance());
        }
        return players[uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length))) % players.length].transfer(address(this).balance);
    }

    // reset the lottery for next round
    function resetLottery() public onlyManager {
        // initialize players state variable to an empty dynamic array
        players = new address payable [](0); // 0 is the size of the new dynamic array of type payable address
    }


}