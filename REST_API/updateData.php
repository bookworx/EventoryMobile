<?php //CREATE DATA

	include 'conexion.php';

	$supplierID = $_POST['supplierID'];
	$supplierPhone = $_POST['supplierPhone'];
	$supplierAddress = $_POST['supplierAddress'];
	$supplierRate = $_POST['supplierRate'];
    $supplierYears = $_POST['supplierYears'];
	$supplierBio = $_POST['supplierBio'];
	$supplierCategory = $_POST['supplierCategory'];
	$supplierFacebook = $_POST['supplierFacebook'];
		
	$sql = "INSERT INTO $tbl_supplier
					(supplierPhone,
					supplierAddress,
					supplierRate,
					supplierYears,
					supplierBio,
					supplierCategory,
					supplierFacebook)
			VALUES ('$supplierPhone',
					'$supplierAddress',
					'$supplierRate',
					'$supplierYears',
					'$supplierBio',
					'$supplierCategory',
					'$supplierFacebook')";

	$result = $conn->query($sql);
	echo "success";
	$conn->close();
	return;

?>