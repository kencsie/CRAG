#!/bin/sh
if [ -f .env ]; then
  # grep -v '^#' 忽略註解行
  # xargs 將每一行轉換成 export 的參數
  export $(grep -v '^#' .env | xargs)
fi

cd scripts
dataset=popqa

# 顯示讀取的key（測試用）
echo "--------------------------------"
echo "Current Dir: $(pwd)"
echo "OpenAI Key: ${OPENAI_KEY:0:5}******"
echo "Search Key: ${SEARCH_KEY:0:5}******"
echo "--------------------------------"

python internal_knowledge_preparation.py \
--model_path ../models/retrieval \
--input_queries ../data/$dataset/sources \
--input_retrieval ../data/$dataset/retrieved_psgs \
--decompose_mode selection \
--output_file ../data/$dataset/ref/correct 

python external_knowledge_preparation.py \
--model_path ../models/retrieval \
--input_queries ../data/$dataset/sources \
--openai_key $OPENAI_KEY \
--search_key $SEARCH_KEY \
--task $dataset --mode wiki \
--output_file ../data/$dataset/ref/incorrect 

python combined_knowledge_preparation.py \
--correct_path ../data/$dataset/ref/correct \
--incorrect_path ../data/$dataset/ref/incorrect \
--ambiguous_path ../data/$dataset/ref/ambiguous 
