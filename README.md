# Cryptonita

Este repositório tem como objetivo auxiliar na implementação da encriptação de mensagens enviadas na integração com a Todo Cartões.

## Processo para a integração

Para realizar adequadamente essa integração as etapas a seguir devem ser seguidas:

1. Cadastro da Todo Cartões como Card Provider.
2. Encriptação do dado no momento de checkout na página web.

### Observação iniciais

O dado a ser enviado (RedemptionCode) para a Todo Cartões deve respeitar o seguinte formato:
```
NÚMERO_DO_CARTÃO.SENHA_ENCRIPTADA
```
Onde o NÚMERO_DO_CARTÃO possui 16 dígitos. No total o RedemptionCode deve possuir até 255 caracteres.

### Cadastro da Todo Cartões como Card Provider

Para realizar essa etapa os seguintes passos devem ser executados na api da vtex:

* Cadastrar a Todo como um GiftCardProvider através de um request para o endpoint específico.

Request a ser executado:
```
curl --request PUT \
  --url 'https://api.vtex.com/{{account_name}}/giftcardproviders/:giftcardprovider_name' \
  --header 'Accept: application/vnd.vtex.giftcardproviders.v1+json' \
  --header 'Content-Type: application/vnd.vtex.giftcardproviders.v1+json' \
  --header 'X-VTEX-API-AppKey: {{vtex_app_key}}' \
  --header 'X-VTEX-API-AppToken: {{vtex_app_token}}' \
  --data '{
    "serviceUrl": "https://gateway.todocartoes.com.br/api/v1/{{name}}",
    "oauthProvider": "vtex",
    "preAuthEnabled": true,
    "cancelEnabled": true
}'
```

Importante ressaltar que a URL indicada pela chave `serviceUrl` está indicada como `https://gateway.todocartoes.com.br/api/v1/{{account_name}}`, onde `{{name}}` é uma string, sem espaços ou caracteres especiais. Este nome deve ser passado para TodoCartões, caso a criação do `GiftCardProvider` não tenha sido feita pela própria TodoCartões.

* Verificar se a Todo foi cadastrada como GiftCardProvider.

Request a ser executado:
```
curl --request GET \
  --url 'https://api.vtex.com/{{account_name}}/giftcardproviders' \
  --header 'Accept: application/vnd.vtex.giftcardproviders.v1+json' \
  --header 'Content-Type: application/vnd.vtex.giftcardproviders.v1+json' \
  --header 'X-VTEX-API-AppKey: {{vtex_app_key}}' \
  --header 'X-VTEX-API-AppToken: {{vtex_app_token}}'
```
Para maiores informações sobre os requests a serem executados acesse essa [documentação](https://documenter.getpostman.com/view/2516022/RVfwjBPd).
Para maiores informações sobre o appKey e o appToken da VTEX acesse esse [link](https://help.vtex.com/pt/tutorial/criar-appkey-e-apptoken-para-autenticar-integracoes).

Para facilitar a execução dos passos acima é possível usar o Postman.
Para maiores informações acesse a [página do Postman](https://www.getpostman.com/).

Caso ainda ocorram dificuldades, entre em contato com a Todo.

### Encriptação do dado no momento de checkout na página web

Para essa etapa, deve-se fazer o uso da biblioteca JSEncrypt. Esta estratégia pode ser utilizada em checkouts VTEX que não possuem um campo de senha a parte.

Esse repositório apresenta um exemplo do uso dessa biblioteca que está presente no arquivo [index.html](index.html).
Esse exemplo pode ser acessado [aqui](https://todocartoes.github.io/cryptonita/).

Para realizar essa etapa os seguintes passos devem ser executados:

* Obter com a Todo Cartões a chave pública necessária para encriptar o dado a ser transmitido.
* Implementar a criptografia do dado no frontend com o uso da biblioteca JSEncrypt (conforme o exemplo apresentado).
```
// Você precisa inserir o jsencrypt no seu frontend
// Aqui está o CDN: https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/2.3.1/jsencrypt.min.js
// Ou você pode incluir o .min.js, que está neste repositório.

// inicializa o jsencrypt
var encrypt = new JSEncrypt();

// localiza e atribui a chave pública
var pub_key = $('#caminho_pub_key').val();
encrypt.setPublicKey(pub_key);

// encripta a senha baseando-se na chave pública.
var senha_cartao = $('#caminho_senha_cartao').val();
var encrypted = encrypt.encrypt(senha_cartao);
```
* Enviar o dado no formato definido anteriormente (RedemptionCode = NÚMERO_DO_CARTÃO.SENHA_ENCRIPTADA).

Para maiores informações acesse a documentação da biblioteca [JSEncrypt](https://github.com/travist/jsencrypt).

## Sobre esse repositório

O repo possui exemplos simples para encriptar e decriptar mensagens a partir de um par de chaves pública e privada.
Os códigos aqui apresentados possuem o propósito único de realizar testes.
As implementações finais devem ser melhoradas e adequadas a cada caso de uso.
Para maiores informações consulte a seção de referências.

## Contribuindo

Para contribuir com esse repositório siga o [Guia de contribuição](CONTRIBUITION_GUIDE.md).

## Notas finais

Essa documentação foi feita para ser simples e direta.
Se ainda ocorrerem problemas ou dúvidas, entre em contato com a Todo Cartões.

## Referências
* [OpenSSL](https://www.openssl.org/)
* [JSEncrypt](https://github.com/travist/jsencrypt)
* [Ruby Base64 Module](https://ruby-doc.org/stdlib-2.3.1/libdoc/base64/rdoc/Base64.html)
* [Ruby Openssl Module](https://docs.ruby-lang.org/en/2.1.0/OpenSSL.html)
* [VTEX](https://documenter.getpostman.com/view/18468/RVfqmDgC#be8d60e4-5b30-5daf-c7b8-f8f2503a1c39)
