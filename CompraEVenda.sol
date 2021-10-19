pragma solidity 0.8.9;

contract CompraEVenda {
    // Autor: Alexandre
    string comprador;
    string vendedor;
    string matricula;
    string cartorio;
    string dataDeVencimento;
    bool quitado = false;
    uint public valorTotal = 100000;
    uint public valorDaEntrada;
    uint public valorEmAberto;
    uint public quntidadeDeParcelas;
    uint public valorDaParcela;
    uint porcentagemDaMulta;
    
    function pagarEntrada(uint _valorPagamento) public returns(uint, string memory){
        valorDaEntrada = _valorPagamento;
        valorEmAberto = valorTotal - _valorPagamento;
        return(valorEmAberto, "valor em aberto");
    }
    
    
}

