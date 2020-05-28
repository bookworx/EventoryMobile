<?php
include 'conexion.php';

$db_data = array();

$sql = "SELECT
tbl_useraccounts.fullName,
tbl_useraccounts.email,
tbl_supplier.supplierID,
tbl_supplier.supplierPhone,
tbl_supplier.supplierAddress,
tbl_supplier.supplierRate,
tbl_supplier.supplierYears,
tbl_supplier.supplierBio,
tbl_supplier.supplierCategory,
tbl_supplier.supplierFacebook
FROM
tbl_supplier
INNER JOIN tbl_useraccounts ON tbl_useraccounts.accountId = tbl_supplier.accountID";

$result = $conn->query($sql);
if($result->num_rows > 0){
	while($row = $result->fetch_assoc()){
		$db_data[] = $row;
	}
	// Send back the complete records as a json
	echo json_encode($db_data);
}else{
	echo "error";
}
$conn->close();
return;

?>
