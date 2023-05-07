<?php 
    use DI\Container;
    use Slim\Factory\AppFactory;
    require __DIR__.'/../../vendor/autoload.php';

    //injecting 
    $cont_aux = new \DI\Container();

    AppFactory::setContainer($cont_aux);

    $app = AppFactory::create();
    $container = $app -> getContainer();

    include_once 'routex.php';
    include_once 'config.php';
    include_once 'connection.php';
?>