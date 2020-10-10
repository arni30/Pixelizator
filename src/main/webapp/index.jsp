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
                <input id="file" type="file" accept="image/*" onchange=updateSize()>
                <p>
                total size: <span id="fileSize">0</span>
                </p>
            <div class="row"><span id="output"></span></div>
            <br><br>
            <script>
                function showImage(evt) {
                    var file = evt.target.files; // FileList object

                    var f = file[0]

                    // Only process image files.
                    if (!f.type.match('image.*')) {
                        alert("Только изображения....");
                    }

                    var reader = new FileReader();

                    // Closure to capture the file information.
                    reader.onload = (function(theFile) {
                        return function(e) {
                            // Render thumbnail.
                            var span = document.createElement('span');
                            span.innerHTML = ['<img class="img-thumbnail" src="', e.target.result,
                                '" title="', escape(theFile.name), '"/>'].join('');
                            document.getElementById('output').innerHTML = "";
                            document.getElementById('output').insertBefore(span, null);
                        };
                    })(f);

                    // Read in the image file as a data URL.
                    reader.readAsDataURL(f);
                }
                function reset(evt) {
                    var file = evt.target.files; // FileList object
                    var f = file[0];
                    f = "";
                }

                document.getElementById('file').addEventListener('change', showImage, false);
                document.getElementById('file').addEventListener('load', reset, false);

            </script>

            <p>
                <input type="email" name="email" required multiple>
            </p>


        </div>
    </body>
</html>