pragma solidity 0.8.9;

contract TokenDeImovel {
    /* Autor: Alexandre
    O presente smart contract confere a propriedade de uma fracao ideal do imovel identificado, equivalente ao percentual indicado.
    O primeiro comprador do token terá direito vitalício a 5% dos frutos recebidos pelo eventual titular do token decorrentes de aluguel, arrendamento,
    hospedagem ou qualquer outra forma de renda proveniente do imóvel.
    */
    string public primeiroComprador;
    string public matriculaDoImovel;
    string public cartorio;
    uint public valorImovelTokenizado;
    uint public fracaoIdealEmPorcentagem;
    uint public valorToken;
    uint public tamanhoImovelM2;
   
    
    constructor(
        string memory _primeiroComprador,
        string memory _matriculaDoImovel,
        string memory _cartorio,
        uint _valorImovelTokenizado,
        uint _fracaoIdealEmPorcentagem,
        uint _tamanhoImovelM2
        )
        {
            primeiroComprador = _primeiroComprador;
            matriculaDoImovel = _matriculaDoImovel;
            cartorio = _cartorio;
            valorImovelTokenizado = _valorImovelTokenizado;
            fracaoIdealEmPorcentagem = _fracaoIdealEmPorcentagem;
            tamanhoImovelM2 = _tamanhoImovelM2;
            
            
        }
        
        function calcularValorToken() public returns(uint){
            valorToken = (valorImovelTokenizado * fracaoIdealEmPorcentagem)/100;
            return(valorToken);
            
        }
        
        function calcularTamanhoFracaoIdealM2() public view returns (uint) {
            uint tamanhoFracaoIdealM2 = (fracaoIdealEmPorcentagem * tamanhoImovelM2)/100;
            return (tamanhoFracaoIdealM2);
        }
        
        
    
}
