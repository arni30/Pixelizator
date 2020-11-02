<%--
  Created by IntelliJ IDEA.
  User: oarnopolin
  Date: 10/8/20
  Time: 4:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta name="description" content="Pixelizator">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%--    через 5 секунд переходит на страницу    --%>
<%--        <meta http-equiv="refresh" content="5; URL=http://www.google.com">--%>
        <title>Pizelizator</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/View/style.css"/>
        <script src="http://code.jquery.com/jquery-2.2.4.js"
                type="text/javascript">
            // вызов функции по завершению загрузки страницы
            $(document).ready(function() {
                // вызов функции после потери полем 'userName' фокуса
                $('#submit').click(function() {
                    $.ajax({
                        url : 'Pixelizator',     // URL - сервлет
                        method: 'get',
                        data : {                 // передаваемые сервлету данные
                            userName : $('#pixels').val()
                        },
                        success : function(response) {
                            // обработка ответа от сервера
                            $('#ajaxUserServletResponse').text(response);
                        },
                        error:
                            console.log("pizda");
                    });
                });
            });
        </script>

    </head>

    <body>
        <h1>Pixelizator</h1>
        <div class="row">
            <!-- with input that accepts one file -->
<%--            <form method="post" enctype="multipart/form-data">--%>
                <label for="file" class="custom-file-upload">
                    <input name="submit" id="file" type="file" class="inputfile" accept="image/*">
                    Choose a file
                </label>
                <br>
                pixels:
                <input type="range" id="pixels" name="pixels" min="0" max="20" step="1" value="2" onclick="updateTextInput(this.value);">
                <label id="textInput" content="pixels:">
                    2
                </label>
                <br>
                <button id="submit">Pixelate</button>
<%--            </form>--%>
            <div>
                <p>
                    total size: <span id="fileSize">0</span>
                </p>
<%--                <%String imgPath;--%>
<%--                    if (request.getAttribute("imgName") != null)--%>
<%--                        imgPath = ".." + request.getContextPath() + "/uploadFiles/" + request.getAttribute("imgName");--%>
<%--                    else--%>
<%--                        imgPath = "";--%>
<%--                %>--%>
                <%String newImgPath;
                    if (session.getAttribute("newImgName") != null)
                        newImgPath = request.getContextPath() + "/uploadFiles/" + session.getAttribute("newImgName");
                    else
                        newImgPath = "";
                %>
                <img id="clientImage" src="">
            </div>
            <span id="ajaxUserServletResponse"></span>
            <br><br>
            <div>
                <img id="newImg" src="<%= newImgPath%>">
            </div>
            <div>
                <a href="<%=newImgPath%>" download>
                    <button id="downloadButton">
                        Download
                    </button>
                </a>
            </div>


        </div>
    </body>
    <script>
        // function update_size(){
        //     $(document).on("click", "#submit", function() { // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
        //         $.get("Servlet", function(responseText) {   // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
        //             $("#row").text(responseText);           // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
        //         });
        //     });
        //     document.getElementById('fileSize').innerHTML = document.getElementById('clientImage').size;
        // }
        function updateTextInput(val) {
            document.getElementById('textInput').textContent=val
        }
        document.getElementById("file").addEventListener('change', function() {
            if (this.files && this.files[0]) {
                var image = document.getElementById("clientImage");  // $('img')[0]
                image.src = URL.createObjectURL(this.files[0]); // set src to blob url

                var img= this.files[0].size;
                var imgsize=img/1024;
                document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
            }
        });
        function reset(evt) {
            var file = evt.target.files; // FileList object
            var f = file[0];
            f = "";
        }
    </script>
</html>