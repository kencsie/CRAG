head -n 10 data/popqa/raw/popqa_longtail_w_gs.jsonl > data/popqa/raw/popqa_longtail_w_gs_10.jsonl
bash run_data_preprocess.sh
bash run_knowledge_preparation.sh
bash run_crag_inference.sh