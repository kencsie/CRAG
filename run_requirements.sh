# 安裝git與wget
apt-get update && apt-get install git -y && apt-get install wget -y

# 安裝miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
source ~/miniconda3/bin/activate

# 安裝環境
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
conda create -n CRAG python=3.11 -y
conda activate CRAG
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.2.2/flash_attn-2.2.2+cu122torch2.1cxx11abiTRUE-cp311-cp311-linux_x86_64.whl
pip install -r requirements.txt
# 為了支援舊版程式，需要降版本
pip install openai==0.28

#下載模型與資料集
huggingface-cli download selfrag/selfrag_llama2_7b --local-dir models/generation/selfrag_llama2_7b
pip install gdown
gdown --folder https://drive.google.com/drive/folders/1CRFGsyNguXJwKSvFvJm_82GOOlkWSkW7 -O models/retrieval
huggingface-cli download awinml/popqa_longtail_w_gs --repo-type=dataset --local-dir data/popqa/raw --local-dir-use-symlinks False

