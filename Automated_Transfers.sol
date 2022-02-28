//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;
contract DataTypes{
    uint public playerCount=0;
    uint public pot =0;
    address public dealer;
    mapping(address => player) public players;
    enum level {Novice, Intermediate, Advanced}
    struct player{
        address playerAddress;
        level playerLevel;
        string firstName;
        string lastName;
        uint timeCreated;
    }
    constructor(){
        dealer = msg.sender;
    }
    function addPlayer(string memory firstName, string memory lastName) private{
        player memory newPlayer =player(msg.sender,level.Intermediate, firstName, lastName, block.timestamp);
        players[msg.sender] = newPlayer;
        playersInGame.push(newPlayer);
    }
    function getPlayerLevel(address playerAddress) public view returns(level){
        player storage Player = players[playerAddress];
        return Player.playerLevel;
    }
    function changePlayerLevel(address playerAddress) public{
        player storage Player = players[playerAddress];
        if(block.timestamp >= Player.timeCreated + 60){
            Player.playerLevel = level.Advanced;
        }
    }
    function joinGame(string memory firstName, string memory lastName) payable public{
        require(msg.value == 25 ether,"The joining fee is 25 ether");
        if(payable(dealer).send(msg.value)){
            addPlayer(firstName, lastName);
            playerCount += 1;
            pot += 25;
        }
    }
    function payOutWinners() public{
        require(msg.sender == dealer, "Only the dealer can pay out the winner");
        require(msg.value == pot * (1 ether));
        uint payoutPerWinner = msg.value / (playerCount -1);
        for(uint i=0; i < playersInGame.length; i++){

        }
    }
}