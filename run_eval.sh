cd scripts
python eval.py \
  --input_file ../data/popqa/raw/popqa_longtail_w_gs_10.jsonl \
  --eval_file ../data/popqa/output/popqa_output.txt \
  --metric match
