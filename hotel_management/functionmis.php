<?php
include_once 'db.php';

if (isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    echo $username;
    echo $password;
    $query = "select * from login where username = '$username' and password='$password'";
    $result = mysqli_query($connection, $query);

    $userdetails = mysqli_fetch_assoc($result);

    if($userdetails['username']=='manager')
    {
        header('Location: index.php?room_mang');
    }
    else{

        header('Location: login.php');
    }


}

if (isset($_POST['submit'])) {

    $emp_id = $_POST['emp_id'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $staff_type_id = $_POST['staff_type_id'];
    $shift_id= $_POST['shift_id'];
    $id_card_type = $_POST['id_card_type'];
    $id_card_no = $_POST['id_card_no'];
    $address = $_POST['address'];
    $contact_no = $_POST['contact_no'];
    $salary = $_POST['salary'];

    $name = $first_name . ' ' . $last_name;

    $query = "CALL update_staff('$emp_id', '$name', '$staff_type_id', '$shift_id', '$id_card_type', '$id_card_no', '$address', '$contact_no', '$salary')";
    //echo $query;
    if (mysqli_query($connection, $query)) {
        header('Location: index.php?staff_mang');
    } else {
        echo "Error updating record: " . mysqli_error($conn);
    }

}

if (isset($_GET['empid'])!="")
{
    $deleteQuery = "CALL delete_staff('$emp_id')";
    if (mysqli_query($connection, $deleteQuery)) {
        header('Location: index.php?staff_mang');
    } else {
        echo "Error updating record: " . mysqli_error($connection);
    }
}

?>