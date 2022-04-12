

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
            var loc = window.location.pathname;
            var dir = loc.substring(0, loc.lastIndexOf('/'));
            dir += "/course.html";
            location.href = dir;
          }
          else{
              alert("WARNING!: Wrong Username or Password Entered");
              var loc = window.location.pathname;
              var dir = loc.substring(0, loc.lastIndexOf('/'));
              dir += "/login.html";
              location.href = dir;
          }
        })
        .catch(e => console.log(e));
}

function goToRegister(){
  var loc = window.location.pathname;
  var dir = loc.substring(0, loc.lastIndexOf('/'));
  dir += "/register.html";
  location.href = dir;
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
            var loc = window.location.pathname;
            var dir = loc.substring(0, loc.lastIndexOf('/'));
            dir += "/login.html";
            location.href = dir;
        }
        else
            alert("User already Exist");
    })
    .catch(e => console.log(e));
}

function addCourseConfirm(){
    const ID = parseInt(localStorage.getItem("ID"))
    const courseId = document.getElementById("input").value;
    document.getElementById("input").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {course_id: courseId}

    let URL = `http://localhost:5000/myadditions/${ID}`;

    axios.post(URL, data, config)
    .then(res=>{
      data = res.data;
      if(data.id>0){
        alert("Addition Request Confirm");
      }
      else{
        alert("Addition Request Rejected because of One of the following reasons:\n1) \n2) \n");
      }
      var loc = window.location.pathname;
      var dir = loc.substring(0, loc.lastIndexOf('/'));
      dir += "/add.html";
      location.href = dir;
    })
    .catch(e=>console.log(e))
}

function subCourseConfirm(){
    const ID = parseInt(localStorage.getItem("ID"))
    const curr_course_id = document.getElementById("input").value;
    const subn_course_id = document.getElementById("inputTo").value;
    document.getElementById("input").value="";
    document.getElementById("inputTo").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {curr_course_id: curr_course_id, subn_course_id: subn_course_id}

    let URL = `http://localhost:5000/mysubstitutions/${ID}`;

    axios.post(URL, data, config)
    .then(res=>{
      data = res.data;
      if(data.message>0){
        alert("Substitution Request Confirmed");
      }
      else{
        alert("Substitution Request Rejected because of One of the following reasons:\n1) \n2) \n");
      }

      var loc = window.location.pathname;
      var dir = loc.substring(0, loc.lastIndexOf('/'));
      dir += "/sub.html";
      location.href = dir;    })
    .catch(e=>console.log(e))
}

function withCourseConfirm(){
    const ID = parseInt(localStorage.getItem("ID"));
    const courseId = document.getElementById("input").value;
    document.getElementById("input").value="";
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {course_id: courseId}

    let URL = `http://localhost:5000/mywithdrawals/${ID}`;

    axios.post(URL, data, config)
    .then(res=>{
      console.log(res.data);
      data = res.data;
      if(data.message>0){
        alert("Withdrawal Request Confirmed");
      }
      else{
        alert("Withdrawal Request Rejected because of One of the following reasons:\n1) \n2) \n3)");
      }

      var loc = window.location.pathname;
      var dir = loc.substring(0, loc.lastIndexOf('/'));
      dir += "/with.html";
      location.href = dir;    })
    .catch(e=>console.log(e))
}

function displayCourse(){
    const courseId = document.getElementById("input").value;
    let config = {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        }
      }
    let data = {course_id: courseId}

    let URL = 'http://localhost:5000/course_detail';

    axios.post(URL, data, config)
    .then(res=>{
      console.log(res);
        var data = res.data;
        let body = ``;

          body += `<tr>
          <td class = "text-center">Course ID</td>
          <td class = "text-center">Course Name</td>
          <td class = "text-center">IC ID</td>
          <td class = "text-center">IC name</td>
          <td class = "text-center">capacity</td>
          <td class = "text-center">Seats Left</td>
          </tr><tr> 
          <td>${data.id} </td>
          <td>${data.name}</td>
          <td>${data.IC_id}</td> 
          <td>${data.ic_name}</td>
          <td>${data.capacity}</td>
          <td>${data.seats_left}</td>
          </tr>`;
        document.getElementById("chosenCourse").innerHTML = body;
      })
}

function displayCourseTo(){
  const courseId = document.getElementById("inputTo").value;
  let config = {
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json"
      }
    }
  let data = {course_id: courseId}

  let URL = 'http://localhost:5000/course_detail';

  axios.post(URL, data, config)
  .then(res=>{
    console.log(res);
      var data = res.data;
      let body = ``;

        body += `<tr>
        <td class = "text-center">Course ID</td>
        <td class = "text-center">Course Name</td>
        <td class = "text-center">IC ID</td>
        <td class = "text-center">IC name</td>
        <td class = "text-center">capacity</td>
        <td class = "text-center">Seats Left</td>
        </tr><tr> 
        <td>${data.id} </td>
        <td>${data.name}</td>
        <td>${data.IC_id}</td> 
        <td>${data.ic_name}</td>
        <td>${data.capacity}</td>
        <td>${data.seats_left}</td>
        </tr>`;
      document.getElementById("chosenCourse").innerHTML = body;
    })
}
