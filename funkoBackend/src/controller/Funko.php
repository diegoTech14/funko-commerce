<?php 
    namespace App\controller;
    use Psr\Http\Message\ResponseInterface as Response;
    use Psr\Http\Message\ServerRequestInterface as Request;
    use Psr\Container\ContainerInterface;
    use PDO;


    class Funko extends dbAccess{
    
        const RESOURCE = "Funko";

        public function createAutomatically(Request $request, Response $response, $args){
            $path = "C:\\languagesProjects\\funko-commerce\\funkoBackend\\src\\app\\funkos.json";
            $jsonString = file_get_contents($path);
            $jsonData = json_decode($jsonString, true);
            
            for($count = 0; $count < count($jsonData); $count++){
                
                $result = $this -> createRegister($jsonData[$count], self::RESOURCE);
            }
        
            $status = match($result){ //consultar
                0 => 201,
                1 => 409,
            };
            return $response->withStatus($status);
        }
        /*public function create(Request $request, Response $response, $args){
                $body = json_decode($request->getBody(), 1);
                $result = $this -> createRegister($body, self::RESOURCE);

                $status = match($result){
                    '0' => 201,
                    '1' => 409,
                    '2' => 404
                };
                return $response->withStatus($status);
        }*/
    }
?>