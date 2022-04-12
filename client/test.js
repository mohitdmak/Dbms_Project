

function onSubmit(){
    
const username = document.getElementById("Username").value;
const password = document.getElementById("Password").value;
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
            localStorage.setItem("Name", username);
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

function goToRegister(){
    location.href = "http://127.0.0.1:5500/client/register.html";
}

function goRegister(){
    const username = document.getElementById("Username").value;
    const name = document.getElementById("Name").value;
    document.getElementById("Username").value = "";
    document.getElementById("Name").value = "";

    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    
    let data = {Username: username, Name: name};
    
    let URL = 'http://localhost:5000/register';

    axios.post(URL, data, config)
    .then(res => {
        console.log(res.data);
        if(parseInt(res.data.id)>0){
            alert("Registered!!");
        }
        else
            alert("User already Exist");
    })
    .catch(e => console.log(e));
}

function addCourseConfirm(){
    const courseId = document.getElementById("input").value;
    document.getElementById("input").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {CourseID: courseId}

    let URL = 'http://localhost:5000/addcourse';

    axios.post(URL, data, config)
    .then(res=>{
        console.log(res.data)
    .catch(e=>console.log(e))
    })
}

function subCourseConfirm(){
    const courseId = document.getElementById("input").value;
    document.getElementById("input").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {CourseID: courseId}

    let URL = 'http://localhost:5000/subcourse';

    axios.post(URL, data, config)
    .then(res=>{
        console.log(res.data)
    .catch(e=>console.log(e))
    })
}

function withCourseConfirm(){
    const courseId = document.getElementById("input").value;
    document.getElementById("input").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {CourseID: courseId}

    let URL = 'http://localhost:5000/withcourse';

    axios.post(URL, data, config)
    .then(res=>{
        console.log(res.data)
    .catch(e=>console.log(e))
    })
}

function displayCourse(){
    const courseId = document.getElementById("input").value;
    document.getElementById("input").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {CourseID: courseId}

    let URL = 'http://localhost:5000/showcourses';

    axios.post(URL, data, config)
    .then(res=>{
        console.log(res.data);

        let empty = ``;
        let body = ``;
        let head = `<tr>
        <td class = "text-center">Course ID</td>
        <td class = "text-center">Course Name</td>
        <td class = "text-center">IC ID</td>
        <td class = "text-center">Seats Left</td>
        <td class = "text-center">Capacity</td>
        </tr>`

        res.forEach(r=>{
          body += `<tr> 
        <td>${r.id} </td>
        <td>${r.name}</td>
        <td>${r.IC_ID}</td> 
        <td>${r.seats_left}</td>
        <td>${r.capacity}</td>          
        </tr>`;
        });
        console.log(tab);
        document.getElementById("chosenBody").innerHTML = empty;
        document.getElementById("chosenHead").innerHTML = empty;
        document.getElementById("chosenBody").innerHTML = head;
        document.getElementById("chosenHead").innerHTML = body;
      })

    .catch(e=>console.log(e))
}

