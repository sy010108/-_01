import io
from PIL import Image
from flask import Flask, request, jsonify
import nest_asyncio
from ultralytics import YOLO
import json
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
model = YOLO('C:\\Users\\MSI\\Desktop\\bigdata_project-main\\fastapi\\best.pt')

UPLOAD_FOLDER = os.path.join('staticFiles', 'uploads')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route("/predict", methods=["POST"])
def predict():
    if  request.method == "POST":


    #if request.files.get("image"):
        image_file = request.files["image"]

        # 이미지를 서버쪽에 저장하는 것이 필요한 경우 작업
        #img_filename = secure_filename(image_file.filename)
        #image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], img_filename))
        image_bytes = image_file.read()
        img = Image.open(io.BytesIO(image_bytes))
        # 이미지 사이즈 조절
        img = img.resize((640, 640)) # 이미지 사이즈를 키웠더니 2개의 클래스로 잡히네 원본사이즈는 1개의 클래스로 잡히고
        # print(img)
        # 이미지 형태가 아닌 것으로 받아 들이나.
        results = model.predict(source=img)
        print(results)
        results_json = {"boxes":results[0].boxes.xyxy.tolist(),"classes":results[0].boxes.cls.tolist(), "classname": model.model.names[results[0].boxes.cls.cpu().numpy()[0]]}
        results_json = jsonify(results_json)
        return results_json

        # results = model(img)
        # results_json = {"boxes":results[0].boxes.xyxy.tolist(),"classes":results[0].boxes.cls.tolist()}
        # return {"result": results_json}

app.run(host="0.0.0.0", port=8000)