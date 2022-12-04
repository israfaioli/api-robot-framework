*** Settings ***

Documentation            FakeAPI: https://fakerestapi.azurewebsites.net/index.html
Library                  RequestsLibrary
Library                  Collections
Resource                 ../../api/base/base.robot

*** Variables ***
${ALIAS}                         fakeAPI
${URI}                           /books
&{DICTIONARY_BOOK_15}            id=15
...                              title=Book 15
...                              pageCount=1500

${DATA}                          {"id": 1,"title": "harry potter","description": "harry potter e a pedra filosofal","pageCount": 200,"excerpt": "livro ebook","publishDate": "2022-10-16T19:26:33.508Z"}
&{DICTIONARY_BOOK_NEW}           id=1
...                              title=harry potter
...                              description=harry potter e a pedra filosofal
...                              pageCount=200
...                              excerpt=livro ebook
...                              publishDate=2022-10-16T19:26:33.508Z

${DATA_NEW}                      {"id": 2,"title": "harry potter new book","description": "harry potter e a camera secreta","pageCount": 250,"excerpt": "livro em papel","publishDate": "2023-10-16T19:26:33.508Z"}

&{DICTIONARY_BOOK_NEW_EDIT}      id=2
...                              title=harry potter new book
...                              description=harry potter e a camera secreta
...                              pageCount=250
...                              excerpt=livro em papel
...                              publishDate=2023-10-16T19:26:33.508Z

*** Keywords ***

#########Requisições nos serviços#########

##GET​/api​/v1​/Books
Requisitar todos os livros
    ${RESPONSE}          GET On Session      ${ALIAS}            ${URI}
    Log    ${RESPONSE.text}
    Set Test Variable    ${RESPONSE} 

##GET​/api​/v1​/Books​/{id}
Requisitar o livro
    [Arguments]    ${ID_BOOK}
    ${RESPONSE}          GET On Session      ${ALIAS}            ${URI}/${ID_BOOK}
    Log    ${RESPONSE.text}
    Set Test Variable    ${RESPONSE} 

##POST ​/api​/v1​/Books
Requisitar cadastrar livro
    ${HEADERS}           Create Dictionary        content-type=application/json
    ${RESPONSE}          POST On Session    ${ALIAS}            ${URI}
    ...                                     headers=${HEADERS}
    ...                                     data=${DATA}
    Log                    ${RESPONSE.text}
    Set Test Variable      ${RESPONSE} 

##PUT ​/api​/v1​/Books​/{id}
Requisitar alterar dados do livro
    [Arguments]    ${ID_BOOK}
    ${HEADERS}           Create Dictionary        content-type=application/json
    ${RESPONSE}          PUT On Session     ${ALIAS}            ${URI}/${ID_BOOK}
    ...                                     headers=${HEADERS}
    ...                                     data=${DATA_NEW}
    Log                    ${RESPONSE.text}
    Set Test Variable      ${RESPONSE} 


##DELETE ​/api​/v1​/Books​/{id}    
Requisitar excluir livro
    [Arguments]    ${ID_BOOK}
    ${HEADERS}           Create Dictionary        content-type=application/json
    ${RESPONSE}          DELETE On Session        ${ALIAS}            ${URI}/${ID_BOOK}
    ...                                           headers=${HEADERS}
    Log                    ${RESPONSE.text}
    Set Test Variable      ${RESPONSE} 
    




#########Conferências#########

##Check status code
Conferir o status code
    [Arguments]    ${STATUS_CODE}
    Should Be Equal As Strings    ${RESPONSE.status_code}     ${STATUS_CODE}
        
##Check reason
Conferir o reason
    [Arguments]    ${STATUS_REASON}
    Should Be Equal As Strings    ${RESPONSE.reason}     ${STATUS_REASON}

##Check leght
Conferir se retorna uma lista com "${QTD_BOOKS}" livros
    Length Should Be    ${RESPONSE.json()}    ${QTD_BOOKS}

##Check data json
Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPONSE.json()}    id             ${DICTIONARY_BOOK_15.id}
    Dictionary Should Contain Item    ${RESPONSE.json()}    title          ${DICTIONARY_BOOK_15.title}
    Should Not Be Empty               ${RESPONSE.json()["description"]}
    Dictionary Should Contain Item    ${RESPONSE.json()}    pageCount      ${DICTIONARY_BOOK_15.pageCount}
    Should Not Be Empty               ${RESPONSE.json()["excerpt"]}
    Should Not Be Empty               ${RESPONSE.json()["publishDate"]}

##Check data json    
Conferir se retorna todos os dados do livro cadastrado
    Dictionary Should Contain Item    ${RESPONSE.json()}    id            ${DICTIONARY_BOOK_NEW.id}
    Dictionary Should Contain Item    ${RESPONSE.json()}    title         ${DICTIONARY_BOOK_NEW.title}
    Dictionary Should Contain Item    ${RESPONSE.json()}    description   ${DICTIONARY_BOOK_NEW.description}
    Dictionary Should Contain Item    ${RESPONSE.json()}    pageCount     ${DICTIONARY_BOOK_NEW.pageCount}
    Dictionary Should Contain Item    ${RESPONSE.json()}    excerpt       ${DICTIONARY_BOOK_NEW.excerpt}
    Dictionary Should Contain Item    ${RESPONSE.json()}    publishDate   ${DICTIONARY_BOOK_NEW.publishDate}

##Check data json    
Conferir se retorna todos os dados do livro editado
    Dictionary Should Contain Item    ${RESPONSE.json()}    id            ${DICTIONARY_BOOK_NEW_EDIT.id}
    Dictionary Should Contain Item    ${RESPONSE.json()}    title         ${DICTIONARY_BOOK_NEW_EDIT.title}
    Dictionary Should Contain Item    ${RESPONSE.json()}    description   ${DICTIONARY_BOOK_NEW_EDIT.description}
    Dictionary Should Contain Item    ${RESPONSE.json()}    pageCount     ${DICTIONARY_BOOK_NEW_EDIT.pageCount}
    Dictionary Should Contain Item    ${RESPONSE.json()}    excerpt       ${DICTIONARY_BOOK_NEW_EDIT.excerpt}
    Dictionary Should Contain Item    ${RESPONSE.json()}    publishDate   ${DICTIONARY_BOOK_NEW_EDIT.publishDate}    

##Check delete data
Conferir se livro foi excluido
    Should Be Empty    ${RESPONSE.content} 