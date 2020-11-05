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
        <title>Pixelizator</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/View/style.css"/>
        <script src="http://code.jquery.com/jquery-2.2.4.js"
                type="text/javascript">
        </script>
        <script> var path = "${pageContext.request.contextPath}"</script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/View/script.js"></script>
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
                <span>
                <a id="download" href="" download="image.png">
                    <button id="downloadButton">
                        png
                    </button>
                </a>
                </span>
                <span>
                    <a id="jpg" href="" download="image.jpg">
                        <button id="jpgButton">
                            jpg
                        </button>
                    </a>
                </span>
                <span>
                    <a id="webp" href="" download="image.webp">
                        <button id="webpButton">
                            webp
                        </button>
                    </a>
                </span>
                <span>
                    <a id="bmp" href="" download="image.bmp">
                        <button id="bmpButton">
                            bmp
                        </button>
                    </a>
                </span>
            </div>
        </div>
    </body>
</html>