const { db } = require("../server");
const { update } = require("firebase/database");

app.post('/api/updateuserdata', (req, res) => { // อัพเดทข้อมูล เฉพาะอายุ, วันเดือนปีเกิด, อาชีพและสถานะสมรส
    var username = req.body.username
    var age = req.body.age;
    var birthday = req.body.birthday;
    var career = req.body.career;
    var martial_status = req.body.martial_status;

    try {
        get(ref(db, 'users/' + username))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        mil: new Date().getTime(),
                        date: new Date().toLocaleString(),
                    };

                    // Optional Chaining
                    age && (updateData.age = age);
                    birthday && (updateData.birthday = birthday);
                    career && (updateData.career = career);
                    martial_status && (updateData.martial_status = martial_status);

                    update(ref(db, 'users/' + username), updateData);

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success"
                    });
                } else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

app.post('/api/deleteuserdata', (req, res) => { // ลบข้อมูล
    var username = req.body.username;

    try {
        get(ref(db, 'users/' + username))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'users/' + username));

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success"
                    });
                } else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available"
                    });
                }
            });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});