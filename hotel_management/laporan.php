<?php 
$booking_query = "SELECT * FROM booking NATURAL JOIN customer NATURAL JOIN room WHERE booking.payment_status = 1";
$booking_result = mysqli_query($connection, $booking_query);

?>

<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main" style="margin-top: 2.5rem;">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Income Report</div>
                <div class="panel-body">
                    <table class="table table-striped table-bordered table-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Customer</th>
                                <th>Room No</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>Total Payment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                            $no = 1;
                            while ($booking = mysqli_fetch_assoc($booking_result)) { ?>
                                <tr>
                                    <td><?php echo $no ?></td>
                                    <td><?php echo $booking['customer_name'] ?></td>
                                    <td><?php echo $booking['room_no'] ?></td>
                                    <td><?php echo $booking['check_in'] ?></td>
                                    <td><?php echo $booking['check_out'] ?></td>
                                    <td>Rp.<?php echo $booking['total_price'] ?></td>
                                </tr>
                                <?php $no++; ?>
                            <?php } ?>
                            <tr>
                                <td colspan="5" style="text-align: center;">Total Income</td>
                                <td style="font-weight: bold;">
                                    <?php
                                        $query = "CALL totalpendapatan()";
                                        $process = mysqli_query($connection, $query);
                                        if($process) {
                                            $result = mysqli_fetch_assoc($process);
                                            echo "Rp." . $result['total_pendapatan'];
                                        } else {
                                            echo "Rp.0";
                                        }
                                    ?>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>


</div>