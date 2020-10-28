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
        <script>
            function updateSize() {
                var nBytes = 0,
                    oFiles = document.getElementById("file").files,
                    nFiles = oFiles.length;
                for (var nFileId = 0; nFileId < nFiles; nFileId++) {
                    nBytes += oFiles[nFileId].size;
                }
                var sOutput = nBytes + " bytes";
                // optional code for multiples approximation
                for (var aMultiples = ["KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"], nMultiple = 0, nApprox = nBytes / 1024; nApprox > 1; nApprox /= 1024, nMultiple++) {
                    sOutput = nApprox.toFixed(3) + " " + aMultiples[nMultiple] + " (" + nBytes + " bytes)";
                }
                // end of optional code
                document.getElementById("fileSize").innerHTML = sOutput;
            }
        </script>
    </head>

    <body bgcolor="#7fffd4">
        <h1>Pixelizator</h1>
        <div class="row">
            <!-- with input that accepts one file -->
            <form method="post" enctype="multipart/form-data">
                <input name="submit" id="file" type="file" accept="image/*" onchange=updateSize()>
                <br>
                pixels:
                <input type="range" name="pixels" min="0" max="100" step="1" value="50" onchange="updateTextInput(this.value);">
                <input type="text" id="textInput" content="pixels:" value="50">
                <br>
                <button type="submit"onclick="jQuery('#newImg').load(' #newImg');">send</button>
            </form>
                <p>
                total size: <span id="fileSize">0</span>
                </p>
            <div class="row"><img id="output"></div>
            <br><br>
            <script>
                function updateTextInput(val) {
                    document.getElementById('textInput').value=val;
                }
                document.getElementById("file").addEventListener('change', function() {
                    if (this.files && this.files[0]) {
                        var image = document.getElementById("output");  // $('img')[0]
                        image.src = URL.createObjectURL(this.files[0]); // set src to blob url

                        var img= this.files[0].size;
                        var imgsize=img/1024;
                        document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
                        image.onload = imageIsLoaded;
                    }
                });
                function reset(evt) {
                    var file = evt.target.files; // FileList object
                    var f = file[0];
                    f = "";
                }
                var button = document.getElementById('btn-download');
                button.addEventListener('click', function (e) {
                    var dataURL = canvas.toDataURL('image/png');
                    button.href = dataURL;
                });

                // document.getElementById('file').addEventListener('change', showImage, false);
                // document.getElementById('file').addEventListener('load', reset, false);

            </script>
            <p>
                <img id="newImg" src="${pageContext.request.contextPath}/uploadFiles/<%=request.getAttribute("imgName")%>">
            </p>
        </div>
    </body>
</html>