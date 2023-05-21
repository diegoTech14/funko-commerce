<?php 
    namespace App\controller;
    use Psr\Http\Message\ResponseInterface as Response;
    use Psr\Http\Message\ServerRequestInterface as Request;
    use Psr\Container\ContainerInterface;
    use PDO;

    //Will use these methods on the routes
    class Person extends dbAccess {
        
        const RESOURCE = "Person";

        public function createPerson(Request $request, Response $response, $args){
            $body = json_decode($request->getBody());
            $result = $this -> createRegister($body, self::RESOURCE);
            return $response->withStatus(200);
        }

        public function deletePerson(Request $request, Response $response, $args){
            $result = $this -> deleteRegister($args['id'],self::RESOURCE);
            $status = $result > 0 ? 200 : 404;
            return $response->withStatus($status);


        }

        public function searchPerson(Request $request, Response $response, $args){
            
            $result = $this -> searchRegister(self::RESOURCE, $args['id']);
            $status = !$result ? 404 : 200;

            if($result){
                $response->getBody()->write(json_encode($result));
            }
            return $response
                ->withHeader('Content-type', 'Application/json')
                ->withStatus($status);
        }

        public function editPerson(Request $request, Response $response, $args){
         
            $id = $args['id'];
            $body = json_decode($request->getBody());
            $result = $this -> editRegister($body, self::RESOURCE, $id);            
            $status = match($result[0]){
                '0' => 404,
                '1' => 200,
                '2' => 409
            };
            return $response->withStatus($status);
        }
        
        public function filterPerson(Request $request, Response $response, $args){

            $data = $request->getQueryParams();//parámetros que vienen ocultos o encapsulados en el get
            $result = $this -> filterRegister($data, $args, self::RESOURCE);
            $status = sizeof($result) > 0 ? 200 : 204;
            $response -> getBody() -> write(json_encode($result));

            return $response
                -> withHeader('Content-type', 'Application/json')
                -> withStatus($status);
        }
/*
        public function edit(Request $request, Response $response, $args){
            //(:id, :serie, :modelo, :marca, :categoria, :descripcion)
            $id = $args['id'];
            $body = json_decode($request->getBody());
            $result = $this -> editRegister($body, self::RESOURCE, $id);            
            $status = match($result[0]){
                '0' => 404,
                '1' => 200,
                '2' => 409
            };
            return $response->withStatus($status);
        }

        public function delete(Request $request, Response $response, $args){
            $id = $args['id'];
            $result = $this -> deleteRegister(self::RESOURCE, $args['id']);
            $status = $result > 0 ? 200 : 404;
            return $response->withStatus($status);
        }

        public function search(Request $request, Response $response, $args){
            
            $result = $this -> searchRegister(self::RESOURCE, $args['id']);
            $status = !$result ? 404 : 200;

            if($result){
                $response->getBody()->write(json_encode($result));
            }
            return $response
                ->withHeader('Content-type', 'Application/json')
                ->withStatus($status);
        }

        public function filter(Request $request, Response $response, $args){

            $data = $request->getQueryParams();//parámetros que vienen ocultos o encapsulados en el get
            $result = $this -> filterRegister($data, $args, self::RESOURCE);
            $status = sizeof($result) > 0 ? 200 : 204;
            $response -> getBody() -> write(json_encode($result));
            return $response
                -> withHeader('Content-type', 'Application/json')
                -> withStatus($status);
        }

        public function numRegs(Request $request, Response $response, $args){

            $data = $request->getQueryParams();
            $result['cant'] = $this -> numOfRegisters($data, self::RESOURCE);
            
            $response->getBody()->write(json_encode($result));
            return $response
                -> withHeader('Content-type', 'Application/json')
                -> withStatus(200);
        }

        public function changeOwner(Request $request, Response $response, $args){
                        
            $body = json_decode($request->getBody(), 1);
            $result = $this -> changeOwnerDB(
                ['id' => $args['id'], 'idCliente' => $body['idCliente']]);

            $status = match($result[0]){
                '0' => 404,
                '1' => 200,
                '2' => 409
            };
            return $response->withStatus($status);
        }*/
    }
