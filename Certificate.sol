/*Esta linea de código especifica la versión del compilador de Solidity 
que generará los archivos .bin (bytecode para desplegar al blockchain)
.abi (es el archivo .json que describe el contrato deplegado y sus funciones en el bytecode)
*/
pragma solidity ^0.4.19;

/*Este es el "factory contract" que se encargará de crear los contratos de los certificados.
*/
contract CertificationAuthority {
    
    //Hay que modificar esta direccion, no debe ser publica, solo la puse así para probar
    address public authority;
    address [] public registeredCertificates;
    /*
    Podríamos implementar un mappeo para guardar y relacionar una direccion de un profesor a la direccion de un certificado y otro mappeo
    para relacionar un integer a cada direccion de los profesores para llevar el conteo de los certificados que tiene. (Gasta menos memoria
    hacerlo por mappeo y menos gas si tenemos que buscar los certificados de cada profesor)
    ...
    mapping (address=> address) public certificateOwner;
    mapping (address=> uint) public certificateCounter;
    */
    
    
    constructor(address _authority) internal {
        authority=_authority;
    }
    
    event ContractCreated(address contractAddress);
    
    //Solo debería poder crearlos la autoridad correspondiente...
    function createCertificate(address _owner, string _name, string _lastName, string _courseName, uint _rfc, uint _finishDate) public {
        
       require(msg.sender==authority);
       address newCertificate = new Certificate(_owner, _name, _lastName, _courseName, _rfc, _finishDate);
       
       //Arreglo que contiene la dirección de los certificados emitidos.
       registeredCertificates.push(newCertificate);
       
       /*
       //Esto serviría para contar los certificados por persona y mostrarlos.
       
       certificateOwner[newCertificate] = _owner;
       certificateCounter[_owner] ++;
       */
       
       //Los eventos están hechos para que un cliente externo interactue con el contrato, no se pueden llamar desde adentro del contrato. 
       emit ContractCreated(newCertificate);
    }
    
    function getDeployedCertificates() public view returns (address[]) {
        return registeredCertificates;
    }
    
}

contract Certificate {
    //Aquí declararemos las variable globales
    
    //Dirección del dueño del contrato
    address public owner;
    string public name;
    string public lastName;
    string public courseName;
    uint public rfc;
    uint public finishDate;
    
    constructor(address _owner, string _name, string _lastName, string _courseName, uint _rfc, uint _finishDate) public {
        //Aquí instanciaremos el contrato
        
        //Aquí no usamos = msg.sender porque vamos a utilizar los "factory contracts" para que llame a este constructor.
        //También msg.sender es la dirección de la persona que trata de crear el contrato.
        
        owner =_owner;
        name=_name;
        lastName=_lastName;
        courseName=_courseName;
        rfc=_rfc;
        finishDate=_finishDate;
        
    }
    
    //Esta función de tipo modifier servirá para agregar características y funciones únicas para el dueño.
    modifier onlyOwner() {
        require(msg.sender==owner);
        _;
    }
    
    /*donateEther es una "payable function" que le permite a las personas donar al contrato del certificado ether. 
    Esta función detrás de cámaras recibe dos variables importantes:
    -msg.value: Es la variable que contiene el monto deseado a donar.
    -msg.sender: Es la dirección de quien mandó el dinero.
    */
    function donateEther() public payable {
        /*Esto impone una donación mínima de .0001 ether --> 1 peso aprox...
        Si no se cumple este requerimiento, la transacción se detiene inmediatamente y el gas requerido para
        realizar la transacción es reembolsado al donante.
        */
        require(msg.value > .00013 ether);
    }
    
    //Esta función va a transferir la totalidad del saldo del contrato al "wallet" del usuario.
    //Explicación de porque usamos el modificador external aquí: https://ethereum.stackexchange.com/questions/19380/external-vs-public-best-practices
    function collect() external onlyOwner {
        //El contrato tiene su propio saldo y "this" se refiere al contrato en sí.
        owner.transfer(address(this).balance);
    }
    
    //Esta función le permite al dueño del contrato revisar el saldo de su contrato.
    function getBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }
    
}