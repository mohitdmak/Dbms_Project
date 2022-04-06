

console.log("INCLUDED")
function onSubmit(){
    
    const username = document.getElementById("Username").value;
    const password = document.getElementById("Password").value;
    document.getElementById("Username").value = "";
    document.getElementById("Password").value = "";
    

    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
      
      let data = {Username: username, Password: password};

      let URL = 'http://localhost:5000/login';
      
      axios.post(URL, data, config)
      .then( res => {

          if(parseInt(res.data.id) > 0){
            console.log(res.data);
            localStorage.setItem("ID", res.data.id);
            console.log(localStorage);
            location.href = 'http://127.0.0.1:5500/client/course.html'
          }
          else{
              alert("WARNING!: Wrong Username or Password Entered");
              location.href = 'http://127.0.0.1:5500/client/test.html'
          }
        })
        .catch(e => console.log(e));
}

function goRegister(){
    location.href = "http://127.0.0.1:5500/client/register.html";
}