//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;
contract DataTypes{
    uint public playerCount=0;
    mapping(address => player) public players;
    enum level {Novice, Intermediate, Advanced}
    struct player{
        address playerAddress;
        level playerLevel;
        string firstName;
        string lastName;
        uint timeCreated;
    }
    //In solidity the usual time methods doesn't work . instead you can use the timestamp of a block.this timestamp follows the unix 
    //epoch convention.
    function addPlayer(string memory firstName, string memory lastName) public{
       players[msg.sender] =player(msg.sender,level.Intermediate, firstName, lastName, block.timestamp);
       playerCount +=1;
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
}