<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main" style="margin-top: 2.5rem;">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">History Room</div>
                <div class="panel-body">
                    <table class="table table-striped table-bordered table-responsive" cellspacing="0" width="100%" id="rooms">
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>Aktivitas</th>
                            <th style="color: red;">Jenis Type Room Lama</th>
                            <th style="color: blue;">Jenis Type Room Baru</th>
                            <th style="color: red;">Nomor Room Lama</th>
                            <th style="color: blue;">Nomor Room Baru</th>
                            <th>Tanggal Aktivitas</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $room_query = "SELECT * FROM view_log_room";
                        $rooms_result = mysqli_query($connection, $room_query);
                        if (mysqli_num_rows($rooms_result) > 0) {
                            $no = 1;
                            while ($rooms = mysqli_fetch_assoc($rooms_result)) { ?>
                                <tr>
                                    <td><?php echo $no ?></td>
                                    <td><?php echo $rooms['aktivitas'] ?></td>
                                    <td>
                                        <?php 
                                        $room_query_1 = "SELECT * FROM view_room_type";
                                        $rooms_result_1 = mysqli_query($connection, $room_query_1); 
                                        while($rooms_type = mysqli_fetch_assoc($rooms_result_1)) {
                                            if($rooms_type['room_type_id'] == $rooms['old_room_type']){
                                                echo $rooms_type['room_type'];
                                            }
                                        } ?>

                                    </td>
                                    <td>
                                        <?php 
                                        $room_query_2 = "SELECT * FROM view_room_type";
                                        $rooms_result_2 = mysqli_query($connection, $room_query_2); 
                                        while($rooms_type = mysqli_fetch_assoc($rooms_result_2)) {
                                            if($rooms_type['room_type_id'] == $rooms['new_room_type']){
                                                echo $rooms_type['room_type'];
                                            }
                                        } ?>

                                    </td>
                                    <td><?php echo $rooms['old_room_no'] ?></td>
                                    <td><?php echo $rooms['new_room_no'] ?></td>
                                    <td><?php echo $rooms['created_at'] ?></td>
                                </tr>
                                <?php $no++; ?>
                            <?php }
                        } else {
                            echo "No Rooms";
                        }
                        ?>

                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>


</div>