const loginButn = document.getElementById("Log");
const regBtn = document.getElementById("register");
const Username = document.getElementById("Username");
const Password = document.getElementById("Password");

var bodyFormData = new FormData();
bodyFormData.append("Username", Username);
bodyFormData.append("Password", Password);
const getdata = () => {
    axios({
        method: 'post',
        url: 'http://localhost:5000/login',
        data: bodyFormData
        })
        .then(function (response) {
            //handle success
            console.log(response);
        })
        .catch(function (response) {
            //handle error
            console.log(response);
        });
        /*axios.post("http://localhost:5000/login", {
            Username: `${Username}`,
            Password: `${Password}`
        }).then(response=>{
            console.log(response);
        });8?
        /*axios.get("http://localhost:5000/login").then(response =>{
            console.log(response);
            showOutput(response)
        });*/
    };

function showOutput(res){
    document.querySelector("#res").innerHTML = `
        <h1> Here is the data: ${res.header}</h1>`
}

loginButn.addEventListener('click', getdata);