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
    
    
    function pagarEntrada() public payable returns(uint, string memory){
        require(msg.value == valorDaEntrada, "valor de entrada incorreto");
        require(valorEmAberto == valorTotal, "Entrada ja foi paga.");
        comprador = msg.sender;
        payable(vendedor).transfer(msg.value);
        valorEmAberto = valorTotal - msg.value;
        dataDeVencimento = block.timestamp + 31 * 86400;
        return(valorEmAberto, "valor em aberto");
    }
    
    function pagarParcela() public payable returns(uint, string memory){
        require(msg.value == valorDaParcela, "Valor da parcela incorreto");
        require(valorEmAberto <= valorTotal-valorDaEntrada, "Entrada nao foi paga.");
        require(comprador == msg.sender, "Obrigado, somente o coprador pode executar essa funcao");
        require(block.timestamp <= dataDeVencimento, "Parcela com data de vencimento vencida");
        dataDeVencimento = dataDeVencimento + 31 * 86400;
        valorEmAberto = valorEmAberto - msg.value;
        payable(vendedor).transfer(msg.value);
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




