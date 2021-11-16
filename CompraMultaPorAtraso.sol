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
    
    event PagamentoEntrada(address _comprador, uint _valorPagamento);
    event PagamentoParcela(address _comprador, uint _valorParcela);
    
    constructor(
        uint _valorTotal,
        uint _valorDaEntrada,
        uint _quantidadeDeParcelas,
        string memory _matricula,
        string memory _cartorio,
        address _vendedor,
        uint _porcentagemDaMulta
   
        )
    {
        vendedor = _vendedor;
        valorTotal = _valorTotal;
        valorDaEntrada = _valorDaEntrada;
        quntidadeDeParcelas = _quantidadeDeParcelas;
        matricula = _matricula;
        cartorio = _cartorio;
        valorEmAberto = _valorTotal;
        porcentagemDaMulta = _porcentagemDaMulta;
        valorDaParcela = funcaoValorParcela();
    }
    
    
    function pagarEntrada() public payable returns(uint, string memory){
        require(msg.value == valorDaEntrada, "valor de entrada incorreto");
        require(valorEmAberto == valorTotal, "Entrada ja foi paga.");
        comprador = msg.sender;
        payable(vendedor).transfer(msg.value);
        valorEmAberto = valorTotal - msg.value;
        dataDeVencimento = block.timestamp + 31 * 86400;
        emit PagamentoEntrada(comprador, msg.value);
        return(valorEmAberto, "valor em aberto");
    }
    
    function pagarParcela() public payable returns(uint, string memory){
        require(valorEmAberto <= valorTotal-valorDaEntrada, "Entrada nao foi paga.");
        require(comprador == msg.sender, "Obrigado, somente o coprador pode executar essa funcao");
        if(block.timestamp <= dataDeVencimento){
            require(msg.value == valorDaParcela, "Valor da parcela incorreto");
        }
       else {
           require(msg.value == valorDaParcela + (porcentagemDaMulta*valorTotal/100), "Valor de ser igual ao valor da parcela mais multa por atraso" );
       }
       
        payable(vendedor).transfer(msg.value);
        dataDeVencimento = dataDeVencimento + 31 * 86400;
        valorEmAberto = valorEmAberto - msg.value;
        if(valorEmAberto == 0) {
        quitado = true;
        }
        emit PagamentoParcela(comprador, msg.value);
        return(valorEmAberto, "valor em aberto");
        }
    
    function funcaoValorParcela() public view returns (uint){
        uint calculoValorParcela = (valorTotal - valorDaEntrada)/quntidadeDeParcelas;
        return(calculoValorParcela);
    }
    
    function valorDaMulta() public view returns (uint, string memory){
        require(comprador == msg.sender || vendedor == msg.sender, "Apenas o comprador ou vendedor podem executar");
        uint multa;
        if(block.timestamp > dataDeVencimento + 30 * 86400){
            multa = porcentagemDaMulta*valorTotal/100;
        } else {
            multa = 0;
        }
        return(multa, "valor da multa");
    }
    
} 
