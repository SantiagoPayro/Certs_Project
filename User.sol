pragma solidity ^0.5.17; pragma experimental ABIEncoderV2;

contract UserContract {
    
    struct UserStruct {
        string name;
        string lastName;
        string userEmail;
        string institution;
        int userAge;
        uint index;
        uint completedCerts;
    }
  
  mapping(address => UserStruct) private userStructs;
  address[] private userIndex;

  event LogNewUser   (address indexed userAddress, uint index, string name, string lastName, string userEmail, string institution, int userAge, uint completedCerts);
  event LogUpdateUser(address indexed userAddress, uint index, string name, string lastName, string userEmail, string institution, int userAge, uint completedCerts);
  event LogDeleteUser(address indexed userAddress, uint index);
  
  function isUser(address userAddress) public view returns(bool isIndeed) 
  {
    if(userIndex.length == 0) return false;
    return (userIndex[userStructs[userAddress].index] == userAddress);
  }

  function insertUser(address userAddress, string memory userEmail, string memory name, string memory lastName, string memory institution, int userAge) public returns(uint index) {
    require(isUser(userAddress)==false); //if(isUser(userAddress)) throw; 
    userStructs[userAddress].userEmail = userEmail;
    userStructs[userAddress].name = name;
    userStructs[userAddress].lastName= lastName;
    userStructs[userAddress].institution= institution;
    userStructs[userAddress].userAge = userAge;
    userStructs[userAddress].completedCerts = 0;
    userStructs[userAddress].index = userIndex.push(userAddress)-1;
    
    emit LogNewUser(userAddress, userStructs[userAddress].index, name, lastName, userEmail, institution, userAge, 0);
    return userIndex.length-1;
  }
  
  //Delete user.
  
   function getUser(address userAddress) public view returns(string memory name, string memory lastName, string memory userEmail, string memory institution, int userAge, uint completedCerts, uint index)
  {
    require(isUser(userAddress)==true);//if(!isUser(userAddress)) throw; 
    return(
      userStructs[userAddress].name,
      userStructs[userAddress].lastName,
      userStructs[userAddress].userEmail,
      userStructs[userAddress].institution,
      userStructs[userAddress].userAge,
      userStructs[userAddress].completedCerts, 
      userStructs[userAddress].index);
  } 
  
  //Este funciona pero pues si tienen nombre repetido solo regresa el primer valor que encuentra
  function getUserByName(string memory _name) public view returns(address userAddress, string memory lastName, string memory userEmail, string memory institution, int userAge, uint completedCerts, uint index){

    address _userAddress;
    string memory _lastName;
    string memory _userEmail='';
    string memory _institution='';
    int _userAge;
    uint _completedCerts;
    uint _index;
    uint i=0;
    
    while(keccak256(bytes(userStructs[userIndex[i]].name))!=keccak256(bytes(_name)) && i<userIndex.length){
        i++;
    }
    if(keccak256(bytes(userStructs[userIndex[i]].name))==keccak256(bytes(_name))){
        _userAddress=userIndex[i];
        _lastName=userStructs[userIndex[i]].lastName;
        _userEmail=userStructs[userIndex[i]].userEmail;
        _institution=userStructs[userIndex[i]].institution;
        _userAge=userStructs[userIndex[i]].userAge;
        _completedCerts=userStructs[userIndex[i]].completedCerts;
        _index=userStructs[userIndex[i]].index;
        
    }
    return(_userAddress, _lastName, _userEmail, _institution, _userAge, _completedCerts, _index);
  } 
  
  //Esta funcion regresa todas las direcciones de los usuarios que tengan cierto nombre y se usa para desplegar los usuarios en la pagina de búsqueda.
  function getAddressByName(string memory _name) public view returns(address[] memory direcciones) {

    address[] memory usuarios;
    uint contador=0;
    
    for(uint j=0; j<userIndex.length; j++) {
        if(keccak256(bytes(userStructs[userIndex[j]].name))==keccak256(bytes(_name))){
            contador++;
        }
    }
    if(contador==0) {
        return(usuarios);
    }
    else{
        usuarios= new address[](contador);
        uint i=0;
        for(uint j=0; j<userIndex.length; j++) {
            if(keccak256(bytes(userStructs[userIndex[j]].name))==keccak256(bytes(_name))){
                usuarios[i]=userIndex[j];
                i++;
            }
        }
        return(usuarios);
    }
  }
  
  function getDataByName(string memory _name) public view returns(string[] memory datos) {
    
    uint contador=0;
    for(uint i=0; i<userIndex.length; i++) {
        if(keccak256(bytes(userStructs[userIndex[i]].name))==keccak256(bytes(_name))){
            contador++;
        }          
    }
    if(contador==0){
        return datos;
    }
    else {
        datos= new string[](contador);
        string memory temp;
        string memory x = " ";
        uint j=0;
        for(uint i=0; i<userIndex.length; i++) {
            if(keccak256(bytes(userStructs[userIndex[i]].name))==keccak256(bytes(_name))){
                temp = string(abi.encodePacked(userStructs[userIndex[i]].name,
                    x,userStructs[userIndex[i]].lastName,
                    x,userStructs[userIndex[i]].userEmail,
                    x,userStructs[userIndex[i]].institution,
                    x,userStructs[userIndex[i]].userAge,
                    x,userStructs[userIndex[i]].completedCerts));
                datos[j]=string(abi.encodePacked(userIndex[i],x,temp));
                j++;
            }          
        }
        return(datos);
    } 
  }
}
