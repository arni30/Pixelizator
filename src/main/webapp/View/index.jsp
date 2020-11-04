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
        <title>Pizelizator</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/View/style.css"/>
        <script src="http://code.jquery.com/jquery-2.2.4.js"
                type="text/javascript">
        </script>
        <script>

            $(document).ready(function() {
                $('#submit').click(function() {
                    var form = $('#form')[0];
                    var data = new FormData(form);
                    data.append('type', 'pixelate');
                    console.log(data);
                    if (document.getElementById("file").files.length === 0)
                    {
                        alert ("Сhoose your image");
                    }
                    else {
                        $.ajax({
                            url: 'Pixelizator',     // URL - сервлет
                            method: 'POST',
                            cache: false,
                            processData: false,
                            contentType: false,
                            data: data,
                            success: function (response) {
                                console.log("SUCCESS : ", data);
                                var json = JSON.parse(response);
                                console.log(json);
                                var newImgPath = "<%=request.getContextPath()%>/uploadFiles/" + json.newFile;
                                $('#newImg').attr("src", newImgPath);
                                $('#download').attr("href", newImgPath);
                                $('#load').attr("style", "visibility: visible");
                                $('#newImgDiv').attr("style", "display: initial");

                            },
                        });
                    }
                });
                $('#black').click(function() {
                    var form = $('#form')[0];
                    var data = new FormData(form);
                    data.append('type', 'blackAndWhite');
                    console.log(data);
                    if (document.getElementById("file").files.length === 0)
                    {
                        alert ("Сhoose your image");
                    }
                    else {
                        $.ajax({
                            url: 'Pixelizator',     // URL - сервлет
                            method: 'POST',
                            cache: false,
                            processData: false,
                            contentType: false,
                            data: data,
                            success: function (response) {
                                console.log("SUCCESS : ", data);
                                var json = JSON.parse(response);
                                console.log(json);
                                var newImgPath = "<%=request.getContextPath()%>/uploadFiles/" + json.newFile;
                                $('#newImg').attr("src", newImgPath);
                                $('#download').attr("href", newImgPath);
                                $('#load').attr("style", "visibility: visible");
                                $('#newImgDiv').attr("style", "display: initial");
                            },
                        });
                    }
                });
            });
        </script>

    </head>

    <body>
        <h1>Pixelizator</h1>
        <div class="row">
            <form id="form" method="post" action="Pixelizator" enctype="multipart/form-data" onsubmit="return false;">
                <label for="file" class="custom-file-upload">
                    <input name="file" id="file" type="file" class="inputfile" accept="image/*">
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
                <button id="black">Black-White</button>
            </form>
            <div>
                <p>
                    total size: <span id="fileSize">0</span>
                </p>
            </div>
            <div id="clientImgDiv" style="display: none; float: left; margin-right: 30px; margin-left: 75px" >
                <img id="clientImage" src="">
            </div>
            <div style="display: none;" id="newImgDiv">
                <img id="newImg" src="">
            </div>
            <div id="load" style="visibility: hidden">
                <a id="download" href="" download>
                    <button id="downloadButton">
                        Download
                    </button>
                </a>
            </div>


        </div>
    </body>
    <script>
        function updateTextInput(val) {
            document.getElementById('textInput').textContent=val
        }
        document.getElementById("file").addEventListener('change', function() {
            if (this.files && this.files[0]) {
                document.getElementById("newImg").src = null;
                document.getElementById("download").href = "";
                $('#newImgDiv').attr("style", "display: none");
                $('#clientImgDiv').attr("style", "display: initial");
                $('#load').attr("style", "visibility: hidden");
                var image = document.getElementById("clientImage");  // $('img')[0]
                image.src = URL.createObjectURL(this.files[0]); // set src to blob url

                var img= this.files[0].size;
                var imgsize=img/1024;
                document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
            }
        });
    </script>
</html>