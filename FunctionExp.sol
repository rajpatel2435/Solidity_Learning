// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FunctionExp {
    uint public favouriteNumber = 25;

    // function functionNAme(params) public/private/external/payable/constant/view/pure
    // function name <visibility>
    // in order to performae such oppression we need to use modifiers
    function store(uint _favouriteNumber) public {
        favouriteNumber = _favouriteNumber;
    }

    //  View/pure just read the statement nothing else
    // dont modify any state varibale inside function within view and pure

    // you can not modify any thing inside function

    function retrieve() public view returns (uint) {
        return favouriteNumber;
    }

    // array in solidity
    uint[] listOfFavouriteNumber;

    //  struct in solidity
    struct Person {
        string name;
        uint age;
    }

    // dynamic array in solidity
    Person[] public listOfPerson;

    mapping(string => uint256) public namesToFavouriteNumber; 

    // static array  Person[3] public listOfPerson; any size upto 3

    Person myPerson;

    // struct can not be modified
   // memory temporary storage as we are ot declaring it
   //memory ype is temporary and can be modified
//    calldata temporary and can not be modified

    function addPerson(string memory _name, uint _age) public {
        myPerson.name = _name;
        myPerson.age = _age;
        listOfPerson.push(myPerson);
    }
}
