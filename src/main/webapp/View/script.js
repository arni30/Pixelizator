function updateTextInput(val) {
    document.getElementById('textInput').textContent=val
}

    $(document).ready(function() {
        document.getElementById("file").addEventListener('change', function() {
            if (this.files && this.files[0]) {
                document.getElementById("newImg").src = "";
                document.getElementById("download").href = "";
                $('#newImgDiv').attr("style", "display: none");
                $('#clientImgDiv').attr("style", "display: initial");
                $('#load').attr("style", "visibility: hidden");
                var image = document.getElementById("clientImage");
                image.src = URL.createObjectURL(this.files[0]);
                var img = this.files[0].size;
                var imgsize = img/1000000;
                document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
            }
        });
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
        var newImgPath =  path + "/uploadFiles/" + json.newFile;
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
        var newImgPath = path + "/uploadFiles/" + json.newFile;
        $('#newImg').attr("src", newImgPath);
        $('#download').attr("href", newImgPath);
        $('#load').attr("style", "visibility: visible");
        $('#newImgDiv').attr("style", "display: initial");
    },
    });
    }
    });
    });