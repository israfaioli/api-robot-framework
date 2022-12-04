*** Settings ***

Resource            ../../api/base/base.robot
Resource            ../../api/request/booksRequest.robot

Suite Setup          Create session fakeAPI
#Suite Teardown       Close session

*** Test Cases ***
##GET​/api​/v1​/Books
Deve buscar todos os livros
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna uma lista com "200" livros

##GET​/api​/v1​/Books​/{id}
Deve buscar um livro
    Requisitar o livro     15
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna todos os dados corretos do livro 15

##POST ​/api​/v1​/Books
Deve cadastrar um novo livro
    Requisitar cadastrar livro
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna todos os dados do livro cadastrado
        
##PUT ​/api​/v1​/Books​/{id}
Deve alterar dados de um livro
    Requisitar alterar dados do livro    1
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna todos os dados do livro editado

##DELETE ​/api​/v1​/Books​/{id}
Deve excluir um livro
    Requisitar excluir livro    15
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se livro foi excluido