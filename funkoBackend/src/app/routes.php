<?php
//es como un acceso directo hacía un directorio y se puede utilizar todo lo que contenga dentro

namespace App\controller;
use Slim\Routing\RouteCollectorProxy;

$app->group('/funko', function (RouteCollectorProxy $funko) {
    $funko -> post('', Funko::class . ':createAutomatically');
});

$app->group('/person', function (RouteCollectorProxy $user) {
    $user -> post('/create', Person::class . ':createPerson');
    $user -> delete('/delete/{id}', Person::class . ':deletePerson');
    $user -> get('/search/{id}', Person::class . ':searchPerson');
    $user -> put('/edit/{id}', Person::class . ':editPerson');
    $user -> get('/filter/{page}/{limit}', Person::class . ':filterPerson');

});


