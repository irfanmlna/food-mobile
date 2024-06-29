<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $response = array();

    // Check if the required POST parameters are set
    if (isset($_POST['id_user']) && isset($_POST['id_food'])) {
        $id_user = $_POST['id_user'];
        $id_food = $_POST['id_food'];

        // Sanitize inputs to prevent SQL injection
        $id_user = mysqli_real_escape_string($koneksi, $id_user);
        $id_food = mysqli_real_escape_string($koneksi, $id_food);

        // Insert the new favorite into tb_favorite
        $insert = "INSERT INTO tb_order (id_user, id_food) VALUES ('$id_user', '$id_food')";
        if (mysqli_query($koneksi, $insert)) {
            $response['value'] = 1;
            $response['message'] = "makanan berhasil ditambahkan ke pesanan";
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal menambahkan makanan ke pesanan";
        }
    } else {
        // Missing required POST parameters
        $response['value'] = 0;
        $response['message'] = "Parameter yang diperlukan tidak ada";
    }

    echo json_encode($response);
} else {
    // Invalid request method
    $response['value'] = 0;
    $response['message'] = "Metode permintaan tidak valid";
    echo json_encode($response);
}

?>
