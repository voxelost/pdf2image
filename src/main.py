import functools
import tempfile

import pdf2image
from flask import Flask, request, send_file
from PIL import Image


def concat_images_vertical(upper_img: Image.Image, lower_img: Image.Image):
    dest_img = Image.new("RGB", (upper_img.width, upper_img.height + lower_img.height))
    dest_img.paste(upper_img, (0, 0))
    dest_img.paste(lower_img, (0, upper_img.height))
    return dest_img


application = Flask(__name__)


@application.route("/", methods=["POST"])  # type: ignore
def upload():
    if len(request.files) < 1:
        return None

    image = functools.reduce(
        concat_images_vertical,
        *[
            pdf2image.convert_from_bytes(pdf.stream.read())
            for pdf in request.files.values()
        ],
    )

    with tempfile.TemporaryDirectory() as tmpdir:
        fname = f"{tmpdir}/out.png"
        image.save(fname)
        return send_file(fname)


application.run("0.0.0.0", 8000)
