from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from my Cloud DevOps CI/CD project!"

@app.route("/health")
def health():
    return "FAIL"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

