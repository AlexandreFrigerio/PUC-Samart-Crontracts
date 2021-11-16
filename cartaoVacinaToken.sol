//SPDX-License-Identifier: MIT
 
pragma solidity 0.8.9;

contract carteiradevacinacao {

    bool imunizado;
    address pessoa;

    struct vacina {
        uint lote;
        uint numerodadose;
        string fabricante;
        string tipo;
        string unidadedevacinacao;
        string vacinador;
    }

    mapping(uint => vacina) public dadosdavacina;

    function vacinacao (
         uint _lote,
         uint _numerodadose,
         string memory _fabricante,
         string memory _tipo,
         string memory _unidadedevacinacao,
         string memory _vacinador,
         address _pessoa
         ) public returns (string memory)
    {
        if (_numerodadose == 1 ){
            pessoa = _pessoa;
            dadosdavacina[_numerodadose]= vacina( _lote, _numerodadose, _fabricante, _tipo, _unidadedevacinacao, _vacinador) ;
            imunizado = false;
            return ("1a dose");
        } else{
            dadosdavacina[_numerodadose]= vacina( _lote, _numerodadose, _fabricante, _tipo, _unidadedevacinacao, _vacinador) ;
            imunizado = true;
            return ("2a dose");
        }
    }

 }
