<?php

$koneksi = mysqli_connect("localhost", "root", "", "db_food");

if($koneksi){

} else {
	echo "gagal Connect";
}

?>