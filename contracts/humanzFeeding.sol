pragma solidity >=0.5.0 <0.6.0;

import "./Humanz.sol";

//our humanz feed from the criptoKitty contract...
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
)
}

contract HumanzFeeding is HumanzFactory {
  //en la linea uno guardamos el contrato de CriptoKitties en una variable
  //en la linea dos llamamos el contrato para usar sus funciones public y external
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);
   

  function feedAndMultiply(uint _humanId, uint _targetDna string memory _species) public{
    require(msg.sender == humanToOwner[_humanId]);
    //Storage se refiere a variables almacenadas permanentemente en la blockchain. 
    //Memory son variables temporales, y son borradas entre llamadas de funciones externas
    //a tu contrato.
    //Piensalo como el hard disk vs RAM.
    Human storage myHuman = humanz[_humanId];

    //targeDna nos ayuda a crear nuestro nuevo Dna
    //dandole vida a nuestro nuevo humano
      _targetDna = _targetDna % dnaModulus;
        uint newDna = (myHuman.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
        _createHuman("NoName", newDna);
  }
    function feedOnKitty(uint _humanId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // Aqui estamos interactuando con el contrato de CK
    //los zombies con propiedades de gato tienen diferente Dna
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}