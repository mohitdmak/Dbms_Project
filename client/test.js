

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
      if(parseInt(data.message)>0){
        alert("Addition Request Confirmed");
      }
      else{
        alert(
            "Addition Request Rejected because of One of the following reasons: \
                \n1) You already have the course as registered. \
                \n2) You have already sent an addition request for the course. \
                \n3) No such course exists \
                \n4) You may have already submitted 2 Addition requests (maximum)."
        );
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
      if(parseInt(data.message)>0){
        alert("Substitution Request Confirmed");
      }
      else{
        alert(
            "Substitution Request Rejected because of One of the following reasons: \
                \n1) Curr course you specified may not actually be a current registered course \
                \n2) Subn course you specified may already be a registered course \
                \n3) You may already have submitted an exact same substitution request \
                \n4) No course with your specified ID may exist \
                \n5) You may have already used 2 substitution requests (maximum)."
        );
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
      if(parseInt(data.message)>0){
        alert("Withdrawal Request Confirmed");
      }
      else{
        alert(
            "Withdrawal Request Rejected because of One of the following reasons: \
                \n1) You may not already have the course registered. \
                \n2) You may have already submitted a withdrawal request for the course.\
                \n3) You may have already submitted 2 withdrawal requests (maximum)."
        );
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
          <td class="text-center">${data.id} </td>
          <td class="text-center">${data.name}</td>
          <td class="text-center">${data.IC_id}</td> 
          <td class="text-center">${data.IC_name}</td>
          <td class="text-center">${data.capacity}</td>
          <td class="text-center">${data.seats_left}</td>
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
        <td class="text-center">${data.id} </td>
        <td class="text-center">${data.name}</td>
        <td class="text-center">${data.IC_id}</td> 
        <td class="text-center">${data.IC_name}</td>
        <td class="text-center">${data.capacity}</td>
        <td class="text-center">${data.seats_left}</td>
        </tr>`;
      document.getElementById("chosenCourseTo").innerHTML = body;
    })
}

function resolveAllQueries(){
  
  const Username = localStorage.getItem("Name");
  const ID = parseInt(localStorage.getItem("ID"))
  const api_url = 
    `http://localhost:5000/resolve`;

// Defining async function
async function getapi(url) {
  
  // Storing response
  const response = await fetch(url);
  
  // Storing data in form of JSON
  var data = await response.json();
  show(data);
}
getapi(api_url);

function show(data) {
  /*let tab = ``;
  data.forEach((r) => {
      tab += `<tr> 
      <td>${r.id} </td>
      <td>${r.name}</td>
      <td>${r.IC_ID}</td> 
      <td>${r.IC_name}</td>
      <td>${r.capacity}</td>          
      </tr>`;
  });*/
  alert(data.message);
  var loc = window.location.pathname;
  var dir = loc.substring(0, loc.lastIndexOf('/'));
  dir += "/course.html";
  location.href = dir;
  }
}
