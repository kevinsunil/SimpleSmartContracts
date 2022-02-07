//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;
contract DataTypes{
    uint public playerCount=0;
    // player[] public players;
    //enum is a record which only allows usage of predefined value ie. the values used in it's decalaration.
    //struct is a record
    mapping(address => player) public players;
    enum level {Novice, Intermediate, Advanced}
    struct player{
        address playerAddress;
        level playerLevel;
        string firstName;
        string lastName;
    }
    function addPlayer(string memory firstName, string memory lastName) public{
       //players.push(player(firstName, lastName));
       players[msg.sender] =player(msg.sender,level.Intermediate, firstName, lastName);
       playerCount +=1;
    }
    function getPlayerLevel(address playerAddress) public view returns(level){
        return players[playerAddress].playerLevel;
    }
}