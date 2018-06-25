pragma solidity ^0.4.11;
contract CarteiraTrabalho {
    
    //atributos
    address proprietario = msg.sender; // dono do contrato
    mapping(uint => address) contratos; // lista de contratos
    uint numContracts=0; // numeros de contratos

    /**
     * verifica se o sender é o dono da carteira de trabalho
     * conta é o address do sender
     * */
    modifier naoDonoDaCarteira(address conta) {
        require(proprietario != conta);
        _;
    }
    
    /**
     * Retorna um contrato de acordo com o identificador
     * identificadorContrato é o identificador do contrato na lista
     * */
    function getContrato(uint identificadorContrato) public view returns(address contratoDeTrabalho){
        return contratos[identificadorContrato];
    }
    
    function setContrato(address identificadorContrato) public naoDonoDaCarteira(msg.sender) view returns (uint indexContrato){
        uint valor = numContracts;
        contratos[numContracts]= identificadorContrato;
        numContracts++;
        return valor;
    }
}


// Contrato de trabalho entre empregado e empregador
contract ContratoTrabalho {
    // atributos
    address private empregado; // empregado associado ao contrato
    address private empregador; // empregador associado ao contrato
    
    uint  salario = 2; // salario do empregado
    string  funcao; // funcao do empregado
    mapping(uint => string) ferias; // lista de ferias
    uint numFerias; // quantidade de ferias
    mapping(uint => string) observacao; // lista de observacoes
    uint numObservacoes; // quantidade de observacoes
    bool  contratoAtivo = true; // status do contrato de trabalho
    
    /**
     * Construtor do contrato
     * empregado_ é o empregado associado ao contrato
     * empregador_ é o empregador associado ao contrato
     * */
     constructor(address empregado_) public {
        empregado = empregado_;
        empregador = msg.sender;
    } 
    
    /**
     * Retorna contrato criado
     * */
    function getContrato()public participaContrato(msg.sender) view returns(address contrato_id){
        return address(this);
    }
    
    /**
     * Altera o valor do empregado
     * empregado_ é o empregado que será associado ao contrato
     * */
    function setEmpregado(address empregado_) public participaContrato(msg.sender){
        empregado = empregado_;
       
    }
    
    /**
     * Altera o valor do empregador
     * empregador_ é o empregador que será associado ao contrato
     * */
    function setEmpregador(address empregador_) public participaContrato(msg.sender){
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
     * verifica se o sender é o empregador
     * conta é o address do sender
     * */
    modifier ehEmpregador(address conta)  {
        require(conta == empregador);
        _;
    }
    
    /**
     * altera a funcao do empregado em relacao ao seu trabalho
     * funcao_ é a nova funcao do empregado
     * */
    function mudarFuncao(string funcao_) public
    ehEmpregador(msg.sender){
        funcao = funcao_;
    }
    
    /**
     * retorna a funcao do empregado em relacao ao seu trabalho
     * */
    function getFuncao() public 
    participaContrato(msg.sender)  view returns(string funcao_atual){
        return funcao;
    }
    
    /**
     * altera o salario do empregado
     * salario_ é o novo salario
     * */
    function mudarSalario(uint salario_) public
    ehEmpregador(msg.sender){
        salario = salario_;
    }
    
    /**
     * retorna o salario do empregado
     * */
    function getSalario() public
    participaContrato(msg.sender) view returns(uint salario_atual){
        return salario;
    }
    
    /**
     * adiciona um registro de ferias na lista de ferias
     * ferias_ é a ferias a ser adicionada
     * */
    function registrarFerias(string ferias_) public
    ehEmpregador(msg.sender) view returns(uint idFerias){
        numFerias++;
        ferias[numFerias] = ferias_;
        return numFerias;
    }
    
    /**
     * retorna um registro de ferias na lista de ferias
     * idferias é a ferias a ser retornada
     * */
    function getFerias(uint idferias) public
    participaContrato(msg.sender) view returns(string ferias_){
        return ferias[idferias];
    }
    
    /**
     * registra uma observacao
     * observacao_ a ser registrada
     * */
    function registrarObservacao(string observacao_) public
    ehEmpregador(msg.sender)  view returns(uint idobservacao){
        numObservacoes++;
        observacao[numObservacoes] = observacao_;
        return numObservacoes;
    }
    
    /**
     * retorna uma observacao
     * idobservacao a ser retornado
     * */
    function getObservacao(uint idobservacao) public
    participaContrato(msg.sender) view returns(string observacao_){
       return observacao[idobservacao];
    }
    
    /**
     * registra uma demissao 
     * */
    function registrarDemissao() public
    ehEmpregador(msg.sender){
        contratoAtivo = false;
    }
    
    /**
     * retorna o stauts do contrato
     * */
    function getStatus() public
    participaContrato(msg.sender) view returns(bool ContratoAtivo_){
       return contratoAtivo;
    }
    
   
}
