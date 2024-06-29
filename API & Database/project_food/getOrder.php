<?php
header("Access-Control-Allow-Origin: *");

include 'koneksi.php'; // Memasukkan file koneksi.php yang berisi detail koneksi database

// Memeriksa apakah parameter id_user disediakan
if (isset($_GET['id_user'])) {
    // Melakukan sanitasi input id_user untuk menghindari SQL injection
    $user_id = mysqli_real_escape_string($koneksi, $_GET['id_user']);

    // Query untuk mengambil makanan favorit untuk user yang ditentukan
    $sql = "SELECT m.id AS id, m.nama_food AS nama_food, m.keterangan AS keterangan, m.gambar_food AS gambar_food
            FROM tb_makanan m
            INNER JOIN tb_order o ON m.id = o.id_food
            WHERE o.id_user = '$user_id'";

    // Menjalankan query
    $result = $koneksi->query($sql);

    // Memeriksa apakah query berhasil dieksekusi
    if ($result) {
        // Memeriksa apakah ada makanan favorit untuk user tersebut
        if ($result->num_rows > 0) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil Menampilkan Data Makanan yang dipesans";
            $response['data'] = array();
            while ($row = $result->fetch_assoc()) {
                $response['data'][] = $row;
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Tidak ada makanan yang dipesan untuk pengguna ini";
            $response['data'] = null;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Terjadi kesalahan saat mengambil data makanan favorit";
        $response['data'] = null;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Parameter 'id_user' tidak diberikan";
    $response['data'] = null;
}

// Mengirimkan response dalam format JSON
echo json_encode($response);
?>
