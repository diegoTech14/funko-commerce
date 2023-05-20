<?php
//es como un acceso directo hacía un directorio y se puede utilizar todo lo que contenga dentro

namespace App\controller;
use Slim\Routing\RouteCollectorProxy;

$app->group('/funko', function (RouteCollectorProxy $funko) {
    $funko -> post('', Funko::class . ':createAutomatically');
});