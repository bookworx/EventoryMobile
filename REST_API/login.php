<?php

    include 'conexion.php';
    if ( isset($_POST['email']) || isset($_POST['passwod']) ){
    $email = $_POST['email'];
    $password = $_POST['password'];

    $consultar=$connect->query("SELECT * FROM tbl_useraccounts WHERE email ='".$email."' and password='".$password."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado[]=$extraerDatos;
    }

    echo json_encode($resultado);


}

    ?>


    