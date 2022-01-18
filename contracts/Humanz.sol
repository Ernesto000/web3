pragma solidity >=0.5.0 <0.6.0;

contract HumanzFactory {

    event NewHuman(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Human {
        string name;
        uint dna;
    }

    Human[] public humanz;

    mapping (uint => address) public humanToOwner;//owner addresses
    mapping (address => uint) ownerHumanCount;//number of zombies per owner
    // We're providing instructions about where the _name variable 
    //should be stored- in memory. This is required for all reference types 
    //such as arrays, structs, mappings, and strings.
    function _createHuman(string memory _name,uint _dna) internal {//private to internal for migration purposes
        //_functions are set to public by default
        uint id = humanz.push(Human(_name, _dna)) -1;//added the id uint to count the arr
        //In Solidity, function execution always needs to start with an external caller. 
        //A contract will just sit on the blockchain until someone calls one of its functions.
        // There will always be a msg.sender.
        humanToOwner[id] = msg.sender;
        ownerHumanCount[msg.sender]++;
        //event call
        emit NewHuman(id, _name, _dna);
    }
    //view & pure depend on where the function is taking the parameters from
      function _generateRandomDna(string memory _str) private view returns (uint) {
          uint rand = uint(keccak256(abi.encodePacked(_str)));
          //keccak256:
          //A hash function basically maps an input into a random 256-bit hexadecimal number. 
          //A slight change in the input will cause a large change in the hash.
          return rand % dnaModulus;
    }

      function createRandomHuman(string memory _name) public { 
        //require makes it so that the function will throw an error 
        //and stop executing if some condition is not true
        require(ownerHumanCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createHuman(_name, randDna);
    }
}