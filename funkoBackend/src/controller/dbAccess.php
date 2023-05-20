<?php 

    namespace App\controller;
    use Psr\Http\Message\ResponseInterface as Response;
    use Psr\Http\Message\ServerRequestInterface as Request;
    use Psr\Container\ContainerInterface;
    use PDO;

    class dbAccess{
        private $container;

        public function __construct(ContainerInterface $c){
            $this -> container = $c;
        }

        public function generateParameters($data){
            $string = "(";
            foreach($data as $field => $value){
                $string .= ":$field,";
            }
            $string = trim($string, ',');
            return $string.")";
        }

        public function createRegister($data, $resource){
            $parameters = $this -> generateParameters($data);
            
            $sql = "SELECT create$resource$parameters;";
            //echo $sql; die();
            $dataArray = [];

            foreach($data as $key => $value){
                $dataArray[$key] = $value;
            }

            $connection = $this -> container -> get('bd');
            $query = $connection -> prepare($sql);
            $query -> execute($dataArray); //devuelve 0 si encontró, 1 duplicados
            $result = $query->fetch(PDO::FETCH_NUM);
            $query = null;
            $con = null;
            return $result[0];
        }
    }
?>