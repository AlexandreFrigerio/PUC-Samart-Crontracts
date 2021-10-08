pragma solidity 0.8.9;

contract CartaoDeVacinacao {
    //autor: Alexandre
    string constant public nome = "Alexandre Frigeio";
    string public unidade = "Republica";
    uint public cnes = 321456;
    string public data = "01/07/2021";
    uint private lote = 654321;
    string constant private fabricante = "janssen";
    bool public imunizado = true;
    string public vacinador = "Joana Silva";
    address private wallet = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}
