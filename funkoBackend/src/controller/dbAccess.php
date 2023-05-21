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
        public function deleteRegister($id, $resource){
            $sql = "SELECT delete$resource(:id);";
    
            $con = $this->container->get('bd');
            $query = $con->prepare($sql);
    
            $query->execute(["id" => $id]);
    
            $res = $query->fetch(PDO::FETCH_NUM);
            $query = null;
            $con = null;
    
            return $res[0];
        }

        public function searchRegister($resource, $id){
            $sql = "CALL search$resource(:id);";
            $con = $this -> container -> get('bd');
            $query = $con -> prepare($sql);
            $query -> execute(['id' => $id]);
            $result = $query->fetch(PDO::FETCH_ASSOC);
            $query = null;
            $con = null;
            return $result;
        }
        public function editRegister($data, $resource, $id){
            $d['id'] = $id;
            $parameters = $this -> generateParameters($data);
            $parameters = substr($parameters, 0, 1) . ":id," . substr($parameters, 1);
            $sql = "SELECT edit$resource$parameters;";
            

            foreach($data as $key => $value){
                $d[$key] = $value;
            }            
            
            $connection = $this -> container -> get('bd');
            $query = $connection -> prepare($sql);
            $query -> execute($d); //devuelve 0 si encontró, 1 duplicados, 2 el cliente no existe
            $result = $query->fetch(PDO::FETCH_NUM);
            $query = null;
            $con = null;
            return $result[0];
        }

        public function filterRegister($data, $args, $resource){
            $limit = $args['limit'];
            $page = ($args['page'] - 1) * $limit;
            
            $stringResult = "";
            foreach($data as $value){
                $stringResult .= "%$value%&"; // formatea
            }
            $sql = "call filter$resource('$stringResult', $page, $limit);";
            $con = $this->container->get('bd');

            $query = $con->prepare($sql);
            $query ->execute();
            $res = $query->fetchAll();//extraer todos los datos
            $query = null;
            $con = null;

            return $res;

        }

    }
?>