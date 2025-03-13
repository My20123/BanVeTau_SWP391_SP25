document.addEventListener("DOMContentLoaded", function () {
    const preview = document.getElementById("preview");
    const display = document.getElementById("display");

    preview.addEventListener("change", function (e) {
        if (e.target.files.length) {
            const src = URL.createObjectURL(e.target.files[0]);
            display.src = src;
        }
    });
});


