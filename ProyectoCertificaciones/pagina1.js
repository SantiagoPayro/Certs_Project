//const { WSANOTINITIALISED } = require("constants");

 function appearText() {
     document.getElementById("text1").style.display='block';
 }

 function loadPageAlta() {
     window.location="pagAlta.html";
 }

 function loadPageInicio() {
     window.location="pagInicio.html";
 }

 function loadPagePerfil() {
     window.location="pagPerfil.html";
 }

 var contract;

 //Cuando cargue el documento esto es lo primero que debe tener:
$(document).ready(function() {
    web3 = new Web3(web3.currentProvider);

    var address = '0x7F8C2873d7E55c540dd9cc3E4e8EcB771E990119';
    var abi = [
        {
            "constant": false,
            "inputs": [
                {
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                },
                {
                    "internalType": "string",
                    "name": "userEmail",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "lastName",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "institution",
                    "type": "string"
                },
                {
                    "internalType": "int256",
                    "name": "userAge",
                    "type": "int256"
                }
            ],
            "name": "insertUser",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "index",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "index",
                    "type": "uint256"
                }
            ],
            "name": "LogDeleteUser",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "index",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "lastName",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "userEmail",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "institution",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "int256",
                    "name": "userAge",
                    "type": "int256"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "completedCerts",
                    "type": "uint256"
                }
            ],
            "name": "LogNewUser",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "index",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "lastName",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "userEmail",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "string",
                    "name": "institution",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "internalType": "int256",
                    "name": "userAge",
                    "type": "int256"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "completedCerts",
                    "type": "uint256"
                }
            ],
            "name": "LogUpdateUser",
            "type": "event"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "internalType": "string",
                    "name": "_name",
                    "type": "string"
                }
            ],
            "name": "getAddressByName",
            "outputs": [
                {
                    "internalType": "address[]",
                    "name": "direcciones",
                    "type": "address[]"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "internalType": "string",
                    "name": "_name",
                    "type": "string"
                }
            ],
            "name": "getDataByName",
            "outputs": [
                {
                    "internalType": "string[]",
                    "name": "datos",
                    "type": "string[]"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                }
            ],
            "name": "getUser",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "lastName",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "userEmail",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "institution",
                    "type": "string"
                },
                {
                    "internalType": "int256",
                    "name": "userAge",
                    "type": "int256"
                },
                {
                    "internalType": "uint256",
                    "name": "completedCerts",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "index",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "internalType": "string",
                    "name": "_name",
                    "type": "string"
                }
            ],
            "name": "getUserByName",
            "outputs": [
                {
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                },
                {
                    "internalType": "string",
                    "name": "lastName",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "userEmail",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "institution",
                    "type": "string"
                },
                {
                    "internalType": "int256",
                    "name": "userAge",
                    "type": "int256"
                },
                {
                    "internalType": "uint256",
                    "name": "completedCerts",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "index",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "internalType": "address",
                    "name": "userAddress",
                    "type": "address"
                }
            ],
            "name": "isUser",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "isIndeed",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        }
    ];
    contract = new web3.eth.Contract(abi, address);
})

//Funcion llamada por un botón para registrar un usuario en la pestaña de pagAlta.
function registerUser() {
    var address,name, lastName, email, institution, age;
    address = $('#tbAddress').val();
    name = $('#tbName').val();
    lastName = $('#tbLastName').val();
    email = $('#tbEmail').val();
    institution = $('#tbInstitution').val();
    age = parseInt($('#tbAge').val());

    web3.eth.getAccounts().then(function(accounts) {
        var acc = accounts[0];
        return contract.methods.insertUser(address,email,name,lastName,institution, age).send({from: acc});
    }).then(function(tx){
        console.log(tx);
    }).catch(function(tx){
        console.log(tx);
    })
}

/*function searchByName() {
    var name = $('#tbSearch').val();
    document.getElementById("text1").style.display='block';
    contract.methods.getUserByName(name).call().then(function(value){ 
        $('#text1').html(value[1].toString());
    })
}
*/

//Funcion llamada por un boton en pagInicio para buscar los datos de usuario por nombre.
function searchByName() {
    var arreglo;
    var name= $('#tbSearch').val();
    var index;
    //Aqui se llama a la funcion que regresa un arreglo con las direcciones de todos los usuarios con el mismo nombre.
    contract.methods.getAddressByName(name).call().then(function(direcciones){
        index = direcciones.length;
        arreglo= direcciones;
        for(var i=0; i<index;i++) {
            //Aqui bal es un arreglo con todos los datos de la dirección en direcciones[i]
            contract.methods.getUser(arreglo[i]).call().then(function(bal){
                var htmlToInsert="";
                htmlToInsert='<div id="container">'
                +'<ul><li>Dirección: '+arreglo[i-1].toString()+'</li>'
                +'<li>Nombre: '+bal[0].toString()+'</li>'
                +'<li>Apellido: '+bal[1].toString()+'</li>'
                +'<li>Email: '+bal[2].toString()+'</li>'
                +'<li>Institución: '+bal[3].toString()+'</li>'
                +'<li>Edad: '+bal[4].toString()+'</li> </ul>'
                +'</div>';
                $("#searchMenu").append(htmlToInsert);
            })
            
        }
    })
   
}

 