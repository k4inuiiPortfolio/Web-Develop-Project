const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();


const PORT = 3001;

app.get('/navbar', (req, res) => {
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/navbar.html'));
});    

app.get('/navbar', (req, res) => {
        res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/navbar.html'));
});

app.use(express.static(path.join(__dirname, "../../sec2_gr9_fe_src/style")));
app.use(express.static('public'));

const cors = require('cors');
app.use(cors({ origin: 'http://localhost:3000' }));
app.use('/picture_product', express.static(path.join(__dirname, 'picture_product')));

app.use(express.static(path.join(__dirname, "../../sec2_gr9_fe_src/popmart")));
app.use(express.static(path.join(__dirname, "../../sec2_gr9_fe_src/picture")));
app.use(express.static(path.join(__dirname, "../../sec2_gr9_fe_src/icon")));
app.use(express.static(path.join(__dirname, "../../sec2_gr9_fe_src/picture_admin")));
app.use(express.static(path.join(__dirname, "../../sec2_gr9_ws_src/picture_admin")));




app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});


app.get('/', (req, res) => {
    console.log('Request at /');
    res.send('Hello World! in plain text');
});

app.get('/home', (req, res) => {
    console.log('Request at /home');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/home.html'));
});

app.get('/search', (req, res) => {
    console.log('Request at /search');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/search.html'));
});

app.get('/aboutus', (req, res) => {
    console.log('Request at /aboutus');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/aboutus.html'));
});

app.get('/accessorysearch', (req, res) => {
    console.log('Request at /accessorysearch');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/accessorysearch.html'));
});

app.get('/detail', (req, res) => {
    console.log('Request at /detail');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/detail.html'));
});

app.get('/edit_admin', (req, res) => {
    console.log('Request at /edit_admin');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/edit_admin.html'));
});

app.get('/edit_product', (req, res) => {
    console.log('Request at /edit_product');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/edit_product.html'));
});

app.get('/login', (req, res) => {
    console.log('Request at /login');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/login.html'));
});

app.get('/Manage_admin', (req, res) => {
    console.log('Request at /Manage_admin');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/Manage_admin.html'));
});

app.get('/Manage_product', (req, res) => {
    console.log('Request at /Manage_product');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/Manage_product.html'));
});

app.get('/menu', (req, res) => {
    console.log('Request at /menu');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/menu.html'));
    
});

app.get('/Regist', (req, res) => {
    console.log('Request at /Regist');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/Regist.html'));

});

app.get('/test', (req, res) => {
    console.log('Request at /test');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/test.html'));

});


app.get('/Add_product', (req, res) => {
    console.log('Request at /test');
    console.log('Retrieve a form');
    res.sendFile(path.join(__dirname, '../../sec2_gr9_fe_src/html/Add_product.html'));

});


/* home menu login */