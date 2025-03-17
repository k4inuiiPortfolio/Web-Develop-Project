[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/OspoeYOK)
เมื่ออาจาร์ยได้รับ Folder แล้ว ให้อาจาร์ยเปิดFile sec2_gr9_database.sql และอาจาร์ยสามารถ excute คำสั่งทั้งหมดได้เลย
![image](https://github.com/user-attachments/assets/6a020301-2e98-42b3-b02c-a23d243db245)

จากนั้นให้อาจาร์ยตรวจสอบว่ามี userชื่อ sec2_gr9_database หรือไม่ ถ้ามีแล้วอาจาร์ยสามารถมาที่ไฟล์ .env ใน Backend และ ตั้งชื่อ username และ password ดังนี้
DB_USER = sec2_gr9_database 
DB_PASSWORD = Sec2Group9 
![image](https://github.com/user-attachments/assets/1fb4bbcc-9fe6-4305-a1dd-06e104cc3e28)

 
จากนั้นอาจาร์ยสามารถเปิด terminal และใช้คำสั่งดังนี้
cd sec2_gr9_ws_src 
cd Backend 
npm install axios bcryptjs cors dotenv express fs multer mysql2 nodemon 
npm start 
และจะได้ผลลัพธ์ดังนี้
![image](https://github.com/user-attachments/assets/fd740f27-31b9-4fdb-94df-89f6c7173c78)

จากนั้นอาจาร์ยจะต้องเปิด new terminal ใหม่ขึ้นมาอีก1 อันในการ run Frontend และใช้คำสั่งดังนี้
cd sec2_gr9_ws_src
cd Forntend 
npm install cors dotenv express nodemon 
npm start
และจะได้ผลลัพธ์ดังนี้
![image](https://github.com/user-attachments/assets/18191ccb-9825-4d17-9007-11e90f38234c)

จากนั้นอาจาร์ยไปที่ Google Chrome และพิมพ์ลงใน url: http://localhost:3001/home ในการทดสอบ  
และจะได้ผลลัพธ์ดังนี้
![image](https://github.com/user-attachments/assets/82eaa030-8d48-4d05-b2cb-5e6316d12b34)

 
