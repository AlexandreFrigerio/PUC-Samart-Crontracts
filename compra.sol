pragma solidity 0.8.9;

contract CompraEVenda {
    // Autor: Alexandre
    address public comprador;
    address public vendedor;
    
    string public matricula;
    string public cartorio;
    
    uint public dataDeVencimento;
    
    bool quitado = false;
    
    uint public valorTotal;
    uint public valorDaEntrada;
    uint public quntidadeDeParcelas;
    uint public porcentagemDaMulta;
    uint public valorDaParcela;
    uint public valorEmAberto;
    
    constructor(
        uint _valorTotal,
        uint _valorDaEntrada,
        uint _quantidadeDeParcelas,
        string memory _matricula,
        string memory _cartorio,
        address _vendedor
   
        )
    {
        vendedor = _vendedor;
        valorTotal = _valorTotal;
        valorDaEntrada = _valorDaEntrada;
        quntidadeDeParcelas = _quantidadeDeParcelas;
        matricula = _matricula;
        cartorio = _cartorio;
        valorEmAberto = _valorTotal;
        valorDaParcela = funcaoValorParcela();
    }
    
    
    function pagarEntrada(uint _valorPagamento) public returns(uint, string memory){
        require(_valorPagamento == valorDaEntrada, "valor de entrada incorreto");
        require(valorEmAberto == valorTotal, "Entrada ja foi paga.");
        comprador = msg.sender;
        valorEmAberto = valorTotal - _valorPagamento;
        dataDeVencimento = block.timestamp + 31 * 86400;
        return(valorEmAberto, "valor em aberto");
    }
    
    function pagarParcela(uint _valorPagamento) public returns(uint, string memory){
        require(_valorPagamento == valorDaParcela, "Valor da parcela incorreto");
        require(valorEmAberto <= valorTotal-valorDaEntrada, "Entrada nao foi paga.");
        require(comprador == msg.sender, "Obrigado, somente o coprador pode executar essa funcao");
        require(block.timestamp <= dataDeVencimento, "Parcela com data de vencimento vencida");
        dataDeVencimento = dataDeVencimento + 31 * 86400;
        valorEmAberto = valorEmAberto - _valorPagamento;
        return(valorEmAberto, "valor em aberto");
        }
    
    function funcaoValorParcela() public view returns (uint){
        uint calculoValorParcela = (valorTotal - valorDaEntrada)/quntidadeDeParcelas;
        return(calculoValorParcela);
    }
    
    function valorDaMulta(uint _porcentagemDaMulta) public view returns (uint, string memory){
        require(comprador == msg.sender || vendedor == msg.sender, "Apenas o comprador ou vendedor podem executar");
        uint multa = (_porcentagemDaMulta*valorTotal)/100;
        return(multa, "valor da multa");
    }
    
}





