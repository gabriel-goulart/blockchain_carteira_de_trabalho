pragma solidity ^0.4.11;
contract CarteiraTrabalho {
    
    //atributos
    address proprietario = msg.sender; // dono do contrato
    mapping(uint => ContratoTrabalho) contratos; // lista de contratos
    uint numContracts; // numeros de contratos

    /**
     * verifica se o sender é o dono da carteira de trabalho
     * conta é o address do sender
     * */
    modifier naoDonoDaCarteira(address conta) {
        require(proprietario != conta);
        _;
    }
    
    /**
     * Cria um contrato de trabalho
     * se não for dono da carteira de trabalho pode criar um contrato de trabalho com o dono do contrato 
     * */
    function contratacao() public naoDonoDaCarteira(msg.sender) view returns(address contratoDeTrabalho){
        contratos[numContracts] = new ContratoTrabalho(proprietario,msg.sender );
        numContracts++;
        return contratos[numContracts-1];
        
    }
    
    /**
     * Retorna um contrato de acordo com o identificador
     * identificadorContrato é o identificador do contrato na lista
     * */
    function getContrato(uint identificadorContrato) public view returns(address contratoDeTrabalho){
        return contratos[identificadorContrato];
    }
}


// Contrato de trabalho entre empregado e empregador
contract ContratoTrabalho {
    // atributos
    address private empregado; // empregado associado ao contrato
    address private empregador; // empregador associado ao contrato
    
    uint  salario = 2 ether; // salario do empregado
    bytes32  funcao; // funcao do empregado
    mapping(uint => bytes32) ferias; // lista de ferias
    uint numFerias; // quantidade de ferias
    mapping(uint => bytes32) observacao; // lista de observacoes
    uint numObservacoes; // quantidade de observacoes
    bool  contratoAtivo = true; // status do contrato de trabalho
    
    /**
     * Construtor do contrato
     * empregado_ é o empregado associado ao contrato
     * empregador_ é o empregador associado ao contrato
     * */
    constructor(address empregado_ , address empregador_) public{
        empregado = empregado_;
        empregador = empregador_;
    }
    
    /**
     * verifica se o sender é participante do contrato
     * conta é o adress do sender
     * */
    modifier participaContrato(address conta)  {
        require(conta == empregado || conta == empregador);
        _;
    }
    
    /**
     * altera a funcao do empregado em relacao ao seu trabalho
     * funcao_ é a nova funcao do empregado
     * */
    function mudarFuncao(bytes32 funcao_) public
    participaContrato(msg.sender){
        funcao = funcao_;
    }
    
    /**
     * retorna a funcao do empregado em relacao ao seu trabalho
     * */
    function getFuncao() public 
    participaContrato(msg.sender) view returns(bytes32 funcao){
        return funcao;
    }
    
    /**
     * altera o salario do empregado
     * salario_ é o novo salario
     * */
    function mudarSalario(uint salario_) public
    participaContrato(msg.sender){
        salario = salario_;
    }
    
    /**
     * retorna o salario do empregado
     * */
    function getSalario() public
    participaContrato(msg.sender) view returns(uint salario){
        return salario;
    }
    
    /**
     * adiciona um registro de ferias na lista de ferias
     * ferias_ é a ferias a ser adicionada
     * */
    function registrarFerias(bytes32 ferias_) public
    participaContrato(msg.sender) view returns(uint idFerias){
        numFerias++;
        ferias[numFerias] = ferias_;
        return numFerias;
    }
    
    /**
     * retorna um registro de ferias na lista de ferias
     * idferias é a ferias a ser retornada
     * */
    function getFerias(uint idferias) public
    participaContrato(msg.sender) view returns(bytes32 ferias){
        return ferias[idferias];
    }
    
    /**
     * registra uma observacao
     * observacao_ a ser registrada
     * */
    function registrarObservacao(bytes32 observacao_) public
    participaContrato(msg.sender)  view returns(uint idobservacao){
        numObservacoes++;
        observacao[numObservacoes] = observacao_;
        return numObservacoes;
    }
    
    /**
     * retorna uma observacao
     * idobservacao a ser retornado
     * */
    function registrarObservacao(uint idobservacao) public
    participaContrato(msg.sender) view returns(bytes32 observacao){
       return observacao[idobservacao];
    }
    
    /**
     * registra uma demissao 
     * */
    function registrarDemissao() public
    participaContrato(msg.sender){
        contratoAtivo = false;
    }
    
    /**
     * retorna o stauts do contrato
     * */
    function getStatus() public
    participaContrato(msg.sender) view returns(bool ContratoAtivo){
       return contratoAtivo;
    }
}