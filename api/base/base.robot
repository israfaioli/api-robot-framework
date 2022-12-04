*** Settings ***

Documentation            FakeAPI: https://fakerestapi.azurewebsites.net/index.html
Library                  RequestsLibrary
Library                  Collections

*** Variables ***
${BASE_URL}              https://fakerestapi.azurewebsites.net/api/v1
${ALIAS}                 fakeAPI

*** Keywords ***
Create session fakeAPI
    Create Session       ${ALIAS}         ${BASE_URL} 