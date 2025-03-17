const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const dotenv = require("dotenv");
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const axios = require('axios');
const bodyParser = require('body-parser');//login

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());  // สำหรับการรับข้อมูลในรูปแบบ JSON
app.use(express.urlencoded({ extended: true }));  // สำหรับการรับข้อมูลจากฟอร์มในรูปแบบ URL-encoded
const LINE_NOTIFY_TOKEN = 'dec5WgC31a2IN84avCw1sN3NvCEf04bV4IOzzbsYWp7';
app.use(bodyParser.json()); //login
app.use('/picture_product', express.static(path.join(__dirname, 'picture_product')));
app.use('/picture_product', express.static('uploads'));






// รูปProduct
const productStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        const pictureFolderPath = path.join(__dirname, 'picture_product');
        if (!fs.existsSync(pictureFolderPath)) {
            fs.mkdirSync(pictureFolderPath, { recursive: true });
        }
        cb(null, pictureFolderPath);  // เก็บไฟล์ในโฟลเดอร์ 'picture_product'
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, uniqueSuffix + path.extname(file.originalname));  // ตั้งชื่อไฟล์ใหม่
    }
});

const productUpload = multer({ storage: productStorage });



// ตั้งค่า multer สำหรับการอัปโหลดไฟล์
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const pictureFolderPath = path.join(__dirname, '../../sec2_gr9_fe_src/picture_admin');
        // สร้างโฟลเดอร์ 'picture' ถ้าไม่มี
        if (!fs.existsSync(pictureFolderPath)) {
            fs.mkdirSync(pictureFolderPath, { recursive: true });
        }
        cb(null, pictureFolderPath);  // กำหนดที่เก็บไฟล์
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, uniqueSuffix + path.extname(file.originalname));  // ตั้งชื่อไฟล์ใหม่
    }
});
const upload = multer({ storage: storage });


// ตั้งค่าการเชื่อมต่อ MySQL
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

// เชื่อมต่อฐานข้อมูล
db.connect(err => {
    if (err) throw err;
    console.log('Connected to MySQL');
});


//------------------------------------START PRODUCT------------------------------------//

// API สำหรับดึงข้อมูลสินค้า
app.get('/products', (req, res) => {
    const sql = `
        SELECT 
            product.product_id AS id,
            product.product_name AS name,
            product.product_price AS price,
            product.product_quantity AS quantity,
            categories.cat_name AS category,
            product.product_size As size,
            product.product_material As material,
            images_product.image_path AS image
        FROM product
        JOIN categories ON product.cat_id = categories.cat_id
        LEFT JOIN images_product ON product.product_id = images_product.id
    `;
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// เหลือตรงนี้
app.put('/editProduct/:product_id', productUpload.single('image_path'), (req, res) => {
    const product_id = req.params.product_id;
    const image_path = req.file ? `http://localhost:3000/picture_product/${req.file.filename}` : null;

    const {
        product_name,
        product_price,
        product_quantity,
        product_size,
        product_material,
        cat_id
    } = req.body;

    const updates = [];
    const values = [];

    if (product_name) {
        updates.push("product_name = ?");
        values.push(product_name);
    }
    if (product_price) {
        updates.push("product_price = ?");
        values.push(product_price);
    }
    if (product_quantity) {
        updates.push("product_quantity = ?");
        values.push(product_quantity);
    }
    if (product_size) {
        updates.push("product_size = ?");
        values.push(product_size);
    }
    if (product_material) {
        updates.push("product_material = ?");
        values.push(product_material);
    }
    if (cat_id) {
        updates.push("cat_id = ?");
        values.push(cat_id);
    }

    if (updates.length === 0 && !image_path) {
        return res.status(400).json({ message: "No data to update." });
    }

    values.push(product_id);
    const sql = `UPDATE product SET ${updates.join(", ")} WHERE product_id = ?`;

    // ใช้ Promise เพื่อจัดการกระบวนการ SQL หลายขั้นตอน
    const executeQuery = (query, params) => {
        return new Promise((resolve, reject) => {
            db.query(query, params, (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        });
    };

    // เริ่มการอัปเดตข้อมูล
    (async () => {
        try {
            // อัปเดตข้อมูลสินค้า
            if (updates.length > 0) {
                const productUpdateResult = await executeQuery(sql, values);
                if (productUpdateResult.affectedRows === 0) {
                    return res.status(404).json({ message: "No product found with the given ID." });
                }
            }

            // จัดการภาพ
            if (image_path) {
                const checkQuery = 'SELECT * FROM images_product WHERE id = ?';
                const imageResults = await executeQuery(checkQuery, [product_id]);

                if (imageResults.length > 0) {
                    // อัปเดต image_path
                    const updateImageQuery = 'UPDATE images_product SET image_path = ? WHERE id = ?';
                    await executeQuery(updateImageQuery, [image_path, product_id]);
                } else {
                    // เพิ่มข้อมูลใหม่
                    const insertImageQuery = 'INSERT INTO images_product (id, image_path) VALUES (?, ?)';
                    await executeQuery(insertImageQuery, [product_id, image_path]);
                }
            }

            res.status(200).json({ message: "Product and image data updated successfully." });
        } catch (err) {
            console.error("Error:", err);
            res.status(500).json({ message: "Error updating product data", error: err });
        }
    })();
});






app.post('/products', productUpload.single('image_path'), (req, res) => {
    const { product_name, product_price, product_quantity, category, product_size, product_material } = req.body;
    // สร้าง URL สำหรับ imagePath
    const imagePath = req.file ? `http://localhost:3000/picture_product/${req.file.filename}` : null;

    console.log(req.file); // ตรวจสอบข้อมูลไฟล์ที่อัปโหลด

    if (!req.file) {
        return res.status(400).send('ไม่มีการอัปโหลดไฟล์.');
    }

    // ตรวจสอบว่าหมวดหมู่มีอยู่ในตาราง categories
    const checkCategorySql = `
        SELECT cat_id FROM categories WHERE cat_name = ?
    `;
    db.query(checkCategorySql, [category], (err, results) => {
        if (err) {
            console.error('Error checking category:', err);
            return res.status(500).json({ message: 'Error checking category.' });
        }

        if (results.length === 0) {
            console.log(`Category "${category}" not found.`);
            return res.status(400).json({ message: `Category "${category}" does not exist.` });
        }

        const cat_id = results[0].cat_id; // ดึง cat_id จากตาราง categories

        // เพิ่มข้อมูลสินค้าในตาราง product
        const productSql = `
            INSERT INTO product (product_name, product_price, product_quantity, cat_id, product_size, product_material)
            VALUES (?, ?, ?, ?, ?, ?)
        `;
        db.query(productSql, [product_name, product_price, product_quantity, cat_id, product_size, product_material], (err, result) => {
            if (err) {
                console.error('Error inserting product:', err);
                return res.status(500).json({ message: 'Failed to add product.' });
            }

            const productId = result.insertId;

            // เพิ่มข้อมูลรูปภาพในตาราง images_product
            if (imagePath) {
                const imageSql = `
                    INSERT INTO images_product (id, image_path)
                    VALUES (?, ?)
                `;
                db.query(imageSql, [productId, imagePath], (err, result) => {
                    if (err) {
                        console.error('Error inserting image:', err);
                        return res.status(500).json({ message: 'Failed to add product image.' });
                    }
                    res.status(200).json({ message: 'Product and image added successfully.' });
                });
            } else {
                res.status(200).json({ message: 'Product added without image.' });
            }
        });
    });
});









// DELETE Endpoint สำหรับลบข้อมูลสินค้า
app.delete('/deleteProduct/:id', (req, res) => {
    const productId = req.params.id;  // รับ product_id จาก URL parameter
    const sql = 'DELETE FROM product WHERE product_id = ?';  // สั่งลบข้อมูลสินค้าในตาราง

    db.query(sql, [productId], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error deleting product.');
        }

        // ตรวจสอบว่าไม่มีข้อมูลที่ถูกลบ (กรณีไม่พบ ID ที่ต้องการลบ)
        if (result.affectedRows === 0) {
            return res.status(404).send('Product not found.');
        }

        // ส่งข้อความเมื่อสินค้าถูกลบสำเร็จ
        res.status(200).send('Product deleted successfully.');
    });
});

//------------------------------------END PRODUCT------------------------------------//




// API สำหรับดึงข้อมูลadmins
app.get('/admins', (req, res) => {
    const sql = `SELECT 
    admin_id, admin_firstname, 
    admin_lastname, admin_sex, 
    admin_tel, admin_email, 
    admin_address, admin_province, 
    admin_zipcode, admin_username, admin_password, admin_retypepassword, image_path FROM admins`;

    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results); // ส่งข้อมูล JSON ไปยัง client
    });
});



//  Testing Insert a new Admin
// method: post
// URL: http://localhost:3000/addAdmin
// body:  raw JSON
// {
//     "admin_firstname": "Peng",
//     "admin_lastname": "Deadeye",
//     "admin_sex": "Male",
//     "admin_tel": "0834444199",
//     "admin_email": "peng.eye@example.com",
//     "admin_address": "97 wow street",
//     "admin_province": "Bangkok",
//     "admin_zipcode": "10500",
//     "admin_username": "pengdie",
//     "admin_password": "wow123",
//     "admin_retypepassword": "wow123",
//     "image_path": "file_example.jpg"
// }

// API สำหรับเพิ่ม Admin
app.post('/addAdmin', upload.single('image_path'), (req, res) => {
    const { admin_firstname, admin_lastname, admin_sex, admin_tel, admin_email, admin_address, admin_province, admin_zipcode, admin_username, admin_password, admin_retypepassword } = req.body;

    if (admin_password !== admin_retypepassword) {
        return res.status(400).send('Password and Retype Password do not match.');
    }

    const image_path = req.file ? req.file.filename : 'default.jpg';  // หากไม่มีไฟล์ จะใช้ 'default.jpg'

    const sql = `
        INSERT INTO admins 
        (admin_firstname, admin_lastname, admin_sex, admin_tel, admin_email, admin_address, admin_province, admin_zipcode, admin_username, admin_password, admin_retypepassword, image_path)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(sql, [admin_firstname, admin_lastname, admin_sex, admin_tel, admin_email, admin_address, admin_province, admin_zipcode, admin_username, admin_password, admin_retypepassword, image_path], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error adding admin.');
        }

        res.status(200).send('Admin added successfully.');
    });
});


// method: put
// URL: http://localhost:3000/editAdmin/6687031
// {
//     "admin_firstname": "John",
//     "admin_lastname": "Doe",
//     "admin_sex": "Male",
//     "admin_tel": "1234567890",
//     "admin_email": "john.doe@example.com",
//     "admin_address": "123 Main St",
//     "admin_province": "Bangkok",
//     "admin_zipcode": "10110",
//     "admin_password": "newpassword123"
// }

// API สำหรับแก้ไขข้อมูล Admin
app.put('/editAdmin/:admin_id', upload.single('image_path'), (req, res) => {
    const admin_id = req.params.admin_id;
    const {
        admin_firstname,
        admin_lastname,
        admin_sex,
        admin_tel,
        admin_email,
        admin_address,
        admin_province,
        admin_zipcode,
        admin_password
    } = req.body;

    const image_path = req.file ? req.file.filename : null; // ชื่อไฟล์ที่อัปโหลด

    // สร้างคำสั่ง SQL สำหรับอัปเดตข้อมูล
    const updates = [];
    const values = [];

    if (admin_firstname) {
        updates.push("admin_firstname = ?");
        values.push(admin_firstname);
    }
    if (admin_lastname) {
        updates.push("admin_lastname = ?");
        values.push(admin_lastname);
    }
    if (admin_sex) {
        updates.push("admin_sex = ?");
        values.push(admin_sex);
    }
    if (admin_tel) {
        updates.push("admin_tel = ?");
        values.push(admin_tel);
    }
    if (admin_email) {
        updates.push("admin_email = ?");
        values.push(admin_email);
    }
    if (admin_address) {
        updates.push("admin_address = ?");
        values.push(admin_address);
    }
    if (admin_province) {
        updates.push("admin_province = ?");
        values.push(admin_province);
    }
    if (admin_zipcode) {
        updates.push("admin_zipcode = ?");
        values.push(admin_zipcode);
    }
    if (admin_password) {
        updates.push("admin_password = ?");
        values.push(admin_password);
    }
    if (image_path) {
        updates.push("image_path = ?");
        values.push(image_path);
    }

    if (updates.length === 0) {
        return res.status(400).json({ message: "No data to update." });
    }

    values.push(admin_id);

    const sql = `UPDATE admins SET ${updates.join(", ")} WHERE admin_id = ?`;

    db.query(sql, values, (err, result) => {
        if (err) {
            console.error("Error:", err);
            return res.status(500).json({ message: "Error updating admin data", error: err });
        }
        res.json({ message: "Admin data updated successfully.", result });
    });
});




// DELETE Endpoint
app.delete('/deleteAdmin/:id', (req, res) => {
    const adminId = req.params.id;
    const sql = 'DELETE FROM admins WHERE admin_id = ?';

    db.query(sql, [adminId], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error deleting admin.');
        }

        if (result.affectedRows === 0) {
            return res.status(404).send('Admin not found.');
        }

        res.status(200).send('Admin deleted successfully.');
    });
});



app.post('/login', (req, res) => {
    const { username, password } = req.body;

    const query = 'SELECT * FROM admins WHERE admin_username = ? AND admin_password = ?';
    db.execute(query, [username, password], (err, result) => {
        if (err) {
            console.error('Database error:', err.message);
            return res.status(500).send('Database error: ' + err.message);
        }

        if (result.length > 0) {
            const insertQuery = 'INSERT INTO login (Username, admin_password) VALUES (?, ?)';
            db.execute(insertQuery, [username, password], (err, insertResult) => {
                if (err) {
                    console.error('Error logging login attempt:', err.message);
                    return res.status(500).send('Error logging login attempt: ' + err.message);
                }
                res.status(200).send('Login successful!');
            });
        } else {
            res.send('Invalid username or password!');
        }
    });
});



app.get("/login", (req, res) => {
    console.log("req select all")
    let sql = `select * from login ;`
    db.query(sql, function (err, result) {
        if (err) {
            throw error;
        }
        res.json(result)
    });
});



app.post('/send', async (req, res) => {
    const { message } = req.body;

    try {
        const response = await axios.post(
            'https://notify-api.line.me/api/notify',
            `message=${encodeURIComponent(message)}`,
            {
                headers: {
                    'Authorization': `Bearer ${LINE_NOTIFY_TOKEN}`,
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
            }
        );

        if (response.status === 200) {
            res.json({ status: 'success', message: 'ส่งข้อความสำเร็จ!' });
        } else {
            res.status(400).json({ status: 'error', message: 'ส่งข้อความล้มเหลว!' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: 'error', message: 'เกิดข้อผิดพลาด!' });
    }
});




//หน้า detail
app.get("/detail/:product_id", (req, res) => {
    const { product_id } = req.params; // รับค่า product_id จาก URL
    const query = `
        SELECT 
            product.product_id AS id,
            product.product_name AS name,
            product.product_price AS price,
            product.product_quantity AS quantity,
            categories.cat_name AS category,
            product.product_size AS size,
            product.product_material AS material,
            images_product.image_path AS image
        FROM product
        JOIN categories ON product.cat_id = categories.cat_id
        LEFT JOIN images_product ON product.product_id = images_product.id
        WHERE product.product_id = ?
        LIMIT 1 -- ดึงมาแค่รูปเดียว
    `;

    db.query(query, [product_id], (err, results) => {
        if (err) {
            console.error("Error fetching product:", err);
            res.status(500).send("Error fetching product");
        } else if (results.length === 0) {
            res.status(404).send("Product not found"); // กรณีไม่พบสินค้า
        } else { //มาวางตัวแปรที่เลือกไว้
            const image = results[0].image;
            const product = {
                product_id: results[0].id,
                product_name: results[0].name,
                product_price: results[0].price,
                product_quantity: results[0].quantity,
                category: results[0].category,
                product_size: results[0].size,
                product_material: results[0].material,
                image_path: image // ส่งคืนรูปภาพ
            };
            res.json(product);
        }
    });
});






// เริ่มเซิร์ฟเวอร์
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});