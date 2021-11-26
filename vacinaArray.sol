// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
contract CarteiraDeVacina {
struct Vacina {
uint index;
string tipo;
uint data;
}
Vacina[] public arrayDeVacina; // o array salva dados e objetos em sequencia. o index comeca no zero: array[0], array[1], array[2]...
function adicionarVacina(string memory _tipo) public {
arrayDeVacina.push(Vacina(arrayDeVacina.length, _tipo, block.timestamp)); // array.push = adiciona um membro ao array
}
function quantidadeTotalDeVacinas() public view returns(uint) {
return (arrayDeVacina.length); // array.length = retorna a quantidade de membros do array
}
function alterarVacina(uint _index, string memory _novoTipo) public {
arrayDeVacina[_index].tipo = _novoTipo;
}
}
